require "resque"

module Integrity
  class ResqueBuilder
    def initialize(namespace='')
      Resque.redis.namespace = namespace
    end
    def call(build)
      Resque.enqueue BuildJob, build.id
    end
  end

  module BuildJob
    @queue = :integrity

    def self.perform(build)
      Builder.build Build.get(build)
    end
  end
end
