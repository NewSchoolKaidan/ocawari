require "oga"
require "open-uri"
require "uri"
require "thread"

require "ocawari/version"
require "ocawari/strategy_delegator"

module Ocawari
  def self.parse(args)
    if args.is_a?(Array)
      work_queue = Queue.new
      mutex = Mutex.new
      collected_images = []

      strategies = args.map do |url|
        encoded_url = URI.encode(url)
        [
          StrategyDelegator.identify(encoded_url), 
          encoded_url
        ]
      end
      strategies.each { |strategy_set| work_queue.push strategy_set }

      workers = (0..4).map do
        Thread.new do
          begin
            while set = work_queue.pop(true)
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
      encoded_url = URI.encode(args)
      strategy = StrategyDelegator.identify(URI.encode(encoded_url))
      strategy.(encoded_url)
    else
      raise StandardError
    end
  end
end
