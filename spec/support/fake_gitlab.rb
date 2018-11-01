require 'sinatra/base'
require 'sinatra/namespace'

class FakeGitlab < Sinatra::Base
  register Sinatra::Namespace

  namespace '/api/v4' do
    get '/projects/:id/repository/commits' do
      verify_params(
        id: params['id'],
        branch: params['ref_name'],
        per_page: params['per_page']
      )
      json_response 200, 'commits'
    end

    get '/projects/:id/repository/branches/:branch' do
      verify_params(
        id: params['id'],
        branch: params['branch']
      )
      json_response 200, 'branch'
    end

    get '/projects/:id/repository/branches' do
      verify_params(
        id: params['id'],
        per_page: params['per_page']
      )
      json_response 200, 'branches'
    end

    get '/projects' do
      verify_params(
        per_page: params['per_page'],
        boolean: params['simple'],
        branch: params['search']
      )
      json_response 200, 'branches'
    end
  end

  private

  def json_response(code, file)
    content_type :json
    status code
    File.open("#{File.dirname(__FILE__)}/gitlab_fixtures/#{File.basename(file)}.json", 'rb').read
  end

  def raise_error(error)
    halt 500, { 'Content-Type' => 'application/json' }, { error: error }.to_json
  end

  def verify_params(opts)
    opts.each do |key, value|
      begin
        valid_params_types[key.to_sym].each do |method, param|
          raise_error("The parameter '#{param}' is invalid") unless value.send(method, param)
        end
      rescue NoMethodError
        raise_error("The parameter '#{param}' is invalid")
      end
    end
  end

  def valid_param_types
    {
      id: { 'responds_to?' => 'to_i', '>' => 0 },
      branch: { 'responds_to?' => 'to_s' },
      commit: { 'match?' => '[0-9a-f]{5,40}' },
      per_page: { '>' => 0, '<' => 101 },
      boolean: { 'in?' => [true, false] }
    }
  end
end
