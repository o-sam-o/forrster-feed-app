require 'json'
require 'net/http'
require 'active_support/core_ext/hash/indifferent_access.rb'


get '/:username' do
  pass if params[:username].blank?
  resp = Net::HTTP.get_response(URI.parse("http://api.forrst.com/api/v2/users/posts?username=#{params[:username]}"))
  data = resp.body
  result = JSON.parse(data).with_indifferent_access
  pass if result[:stat] == 'fail'

  builder do |x|

    x.feed(url: url("/#{params[:username]}")) {
      x.title "Post by Forrster #{params[:username]}"
      x.updated Time.now.utc
 
      result[:resp].each do |post|
        x.entry {
          x.title post[:title]
          x.link(href: post[:url])
          x.id post[:id]
          x.content(post[:formatted_content], type: 'html')
          x.updated post[:updated_at]
          x.author params[:username]
        }
      end
    }

  end
end

not_found do
  "Forrst user not found. Try: #{url("/kyle")}"
end
