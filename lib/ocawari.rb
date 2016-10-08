require "oga"
require "open-uri"
require "addressable/uri"
require "thread"

require "ocawari/version"
require "ocawari/parser"
require "ocawari/strategy_delegator"

module Ocawari
  def self.parse(args)
    case args
    when Array
      work_queue = Queue.new
      mutex = Mutex.new
      collected_images = []

      strategies = args.map do |url|
        uri = prepare_uri(url)
        strategy = StrategyDelegator.identify(uri.to_s)
        [ strategy, uri ]
      end

      strategies.each { |taskset| work_queue << taskset }

      workers = (0..4).map do
        Thread.new do
          begin
            while taskset = work_queue.pop(true)
              strategy, uri = taskset
              task = strategy.new(uri)
              images = task.execute

              mutex.lock
              collected_images += images
              mutex.unlock
            end
          rescue ThreadError
          end
        end
      end.map(&:join)

      collected_images.compact.sort
    when String
      uri = prepare_uri(args)
      strategy = StrategyDelegator.identify(uri.to_s)
      strategy.new(uri).execute
    else
      raise StandardError
    end
  end

  private

  def self.prepare_uri(url)
    u = Addressable::URI.parse(url)
    if u.scheme.nil?
      Addressable::URI.parse("http://#{u.to_s}").normalize
    else
      u.normalize
    end
  end
end
