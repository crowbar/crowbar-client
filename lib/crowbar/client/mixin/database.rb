#
# Copyright 2016, SUSE Linux GmbH
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

require "active_support/concern"

module Crowbar
  module Client
    module Mixin
      #
      # A mixin with barclamp related helpers
      #
      module Database
        extend ActiveSupport::Concern

        REGEX_HOSTNAME = "^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$".freeze
        REGEX_IPV4 = "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$".freeze
        REGEX_USERNAME = "(?=^.{4,63}$)(?=^[a-zA-Z0-9_]*$)".freeze
        REGEX_PASSWORD = "(?=^.{4,63}$)(?=^[a-zA-Z0-9_]*$)(?=[a-zA-Z0-9_$&+,:;=?@#|'<>.^*()%!-]*$)".freeze
        REGEX_DATABASE = "(?=^.{4,253}$)(?=^[a-zA-Z0-9_]*$)(?=[a-zA-Z0-9_$&+,:;=?@#|'<>.^*()%!-]*$)".freeze
        REGEX_PORT = "(?=^.{1,5}$)(?=^[0-9]*$)(?=^([1-9][0-9]{0,3}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])$)".freeze

        included do
          def validate_params!(params)
            fields.each do |field|
              next if valid?(field, params.send(field))
              raise InvalidDatabaseParameterError, field
            end
          end

          def valid?(field, value)
            case field
            when :username
              !value.match(/#{REGEX_USERNAME}/).nil?
            when :password
              !value.match(/#{REGEX_PASSWORD}/).nil?
            when :database
              !value.match(/#{REGEX_DATABASE}/).nil?
            when :host
              !value.match(/#{REGEX_HOSTNAME}|#{REGEX_IPV4}/).nil?
            when :port
              !value.match(/#{REGEX_PORT}/).nil?
            else
              false
            end
          end

          def fields
            [
              :username,
              :password,
              :database,
              :host,
              :port
            ]
          end
        end
      end
    end
  end
end
