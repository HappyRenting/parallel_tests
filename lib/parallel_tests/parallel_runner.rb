# frozen_string_literal: true

module ParallelTests
  # Wrapper around the Parallel gem to avoid naming conflicts
  # with Rails models named "Parallel".
  # This module delegates all calls to ::Parallel (the gem).
  # IMPORTANT: The 'parallel' gem is loaded lazily to avoid
  # defining the Parallel module before Rails models are loaded.
  module ParallelRunner
    class << self
      def processor_count
        parallel_gem.processor_count
      end

      def map_with_index(items, options = {}, &block)
        parallel_gem.map_with_index(items, options, &block)
      end

      private

      def parallel_gem
        @parallel_gem ||= begin
          require "parallel"
          ::Parallel
        end
      end
    end
  end
end
