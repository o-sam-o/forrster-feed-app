enable :inline_templates

get '/:username' do |username|
  pass if username.blank?
  resp = Net::HTTP.get_response(URI.parse("http://api.forrst.com/api/v2/users/posts?username=#{username}"))
  data = resp.body
  result = JSON.parse(data).with_indifferent_access
  pass if result[:stat] == 'fail'

  builder do |x|

    x.feed(url: url("/#{username}")) {
      x.title   "Post by Forrster #{username}"
      x.updated Time.now.utc

      result[:resp].each do |post|
        x.entry {
          x.title     post[:title]
          x.link      href: post[:post_url]
          x.id        post[:id]
          x.content   haml :content, locals: {post: post}, type: 'html'
          x.updated   post[:updated_at]
          x.author    username
        }
      end
    }

  end
end

not_found do
  "Forrst user not found. Try: #{url("/kyle")}"
end

__END__

@@ content

- if post[:url].blank?
  %h2= post[:title]
- else
  %h2
    %a{href: post[:url]}= post[:title]

- unless post[:snaps].blank? || post[:snaps][:mega_url].blank?
  %img{src: post[:snaps][:mega_url]}
- unless post[:content].blank?
  %pre= post[:content]
- unless post[:formatted_description].blank?
  %p= post[:formatted_description]
