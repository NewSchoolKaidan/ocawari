require "oga"
require "open-uri"
require "uri"
require "thread"

require "ocawari/version"
require "ocawari/strategy_delegator"

module Ocawari
  def self.parse(args)
    if args.is_a?(Array)
      worker_queue = Queue.new
      mutex = Mutex.new
      collected_images = []

      strategies = args.map do |url|
        encoded_url = URI.encode(url)
        [
          StrategyDelegator.identify(encoded_url), 
          encoded_url
        ]
      end
      strategies.each { |strategy_set| worker_queue.push strategy_set }

      workers = (0..4).map do
        Thread.new do
          begin
            while set = worker_queue.pop(true)
              strategy, url = set
              images = strategy.(url)
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
      strategy = StrategyDelegator.identify(URI.encode(args))
      strategy.(args)
    else
      raise StandardError
    end
  end
end
