require 'firebase'
require 'pry'
require 'github_api'

base_uri = 'https://g0v-project-hub.firebaseio.com/'
firebase = Firebase::Client.new(base_uri)

response = firebase.get('projects')
response.body.each do |key, element|
  next unless element['workspace']
  begin
    github_workspace = element['workspace'].detect{ |ws| ws['url'].include?('github.com') }
    github_url = github_workspace['url']
    url_split = github_url.split('/')
    repo_name = url_split[-1]
    user_name = url_split[-2]

    response = Github.repos.get(user_name, repo_name)
    if response.status == 200
      payload = { created_at: response.body['created_at'], updated_at: response.body['updated_at'], open_issues_count: response['open_issues_count'] }
      firebase.update("projects/#{key}", payload)
      print "."
    end
  rescue
    print "E"
  end
end