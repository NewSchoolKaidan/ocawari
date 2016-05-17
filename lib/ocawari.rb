require "oga"
require "uri"
require "open-uri"
require "thread"

require "ocawari/version"
require "ocawari/parser"
require "ocawari/strategy_delegator"

module Ocawari
  def self.parse(args)
    if args.is_a?(Array)
      work_queue = Queue.new
      mutex = Mutex.new
      collected_images = []

      strategies = args.map do |url|
        uri = prepare_uri(url)
        strategy = StrategyDelegator.identify(uri.to_s)
        strategy.new(uri)
      end

      strategies.each { |strategy| work_queue << strategy }

      workers = (0..4).map do
        Thread.new do
          begin
            while task = work_queue.pop(true)
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

    elsif args.is_a?(String)
      uri = prepare_uri(args)
      strategy = StrategyDelegator.identify(uri.to_s)
      strategy.new(uri).execute
    else
      raise StandardError
    end
  end

  private

  def self.prepare_uri(url)
    u = URI(url)
    if u.scheme.nil?
      URI("http://#{u.to_s}")
    else
      u
    end
  end
end
