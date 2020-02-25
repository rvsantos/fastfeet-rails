# frozen_string_literal: true

class ApiVersion
  attr_reader :version, :default

  def initialize(options)
    @version = options[:version]
    @defualt = options[:default]
  end

  # check whether version is specified or is defaut
  def matches?(request)
    @default || check_headers(request.headers)
  end

  private

  def check_headers(headers)
    # check version from Accept; expect custom media type `todos`
    accept = headers[:accept]
    accept&.include?("application/vnd.fastfeet.v#{@version}")
  end
end
