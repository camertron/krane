# frozen_string_literal: true
module Krane
  class ContainerOverrides
    attr_reader :command, :arguments, :env_vars, :image

    def initialize(command: nil, arguments: nil, env_vars: [], image: nil)
      @command = command
      @arguments = arguments
      @env_vars = env_vars
      @image = image
    end

    def run!(container)
      container.command = command if command
      container.args = arguments if arguments
      container.image = image if image

      env_args = env_vars.map do |env|
        key, value = env.split('=', 2)
        { name: key, value: value }
      end
      container.env ||= []
      container.env = container.env.map(&:to_h) + env_args
    end
  end
end
