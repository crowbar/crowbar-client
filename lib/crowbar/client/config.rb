#
# Copyright 2015, SUSE Linux GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require "inifile"
require "hashie"
require "singleton"

module Crowbar
  module Client
    class Config
      include Singleton

      attr_writer :options
      attr_writer :config
      attr_writer :values

      def configure(options)
        self.options = Hashie::Mash.new(
          options
        )

        self.config = parser
        self.values = merge
      end

      def defaults
        @defaults ||= Hashie::Mash.new(
          config: nil,
          alias: "default",
          username: "crowbar",
          password: "crowbar",
          server: "http://127.0.0.1:80",
          timeout: 60,
          anonymous: false,
          debug: false
        )
      end

      def options
        @options ||= defaults
      end

      def config
        @config ||= Hashie::Mash.new
      end

      def values
        @values ||= Hashie::Mash.new
      end

      protected

      def merge
        result = {}.tap do |overwrite|
          defaults.keys.each do |key|
            case
            when options[key] != defaults[key]
              overwrite[key] = options[key]
            when config[key].present?
              overwrite[key] = config[key]
            when options[key].present?
              overwrite[key] = options[key]
            else
              overwrite[key] = defaults[key]
            end
          end
        end

        Hashie::Mash.new(
          result
        )
      end

      def parser
        ini = Hashie::Mash.new(
          IniFile.load(
            finder
          ).to_h
        )

        if ini[options.alias]
          ini[options.alias]
        else
          Hashie::Mash.new
        end
      rescue
        Hashie::Mash.new
      end

      def finder
        if options.config.nil?
          paths.detect do |temp|
            File.exist? temp
          end
        else
          options.config
        end
      end

      def paths
        [
          options.config,
          "#{ENV["HOME"]}/.crowbarrc",
          "/etc/crowbarrc"
        ].compact
      end

      class << self
        def configure(options)
          instance.configure(options)
        end

        def defaults
          instance.defaults
        end

        def options
          instance.options
        end

        def config
          instance.config
        end

        def values
          instance.values
        end

        def method_missing(method, *arguments, &block)
          case
          when method.to_s.ends_with?("=")
            key = method.to_s.gsub(/=\z/, "")

            if values.key?(key)
              values[key] = arguments.first
            else
              super
            end
          when values.key?(method)
            values[method]
          else
            super
          end
        end

        def respond_to?(method, include_private = false)
          case
          when method.to_s.ends_with?("=")
            key = method.to_s.gsub(/=\z/, "")

            if values.key?(key)
              true
            else
              super
            end
          when values.key?(method)
            true
          else
            super
          end
        end
      end
    end
  end
end
