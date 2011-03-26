enable :inline_templates

get '/:username' do |username|
  pass if username.blank?
  resp = Net::HTTP.get_response(URI.parse("http://api.forrst.com/api/v2/users/posts?username=#{username}"))
  data = resp.body
  result = JSON.parse(data).with_indifferent_access
  pass if result[:stat] == 'fail'

  content_type 'application/atom+xml'
  builder do |x|

    x.feed(xmlns: "http://www.w3.org/2005/Atom") {

      x.title     "Post by Forrster #{username}"
      x.updated   to_xs_date_time Time.now.utc
      x.link      href: url("/#{username}"), rel: "self"
      x.id        "#{username}:forrster:post:feed"

      result[:resp].each do |post|
        x.entry {
          x.title     post[:title]
          x.link      href: post[:post_url]
          x.id        post[:id]
          x.content   haml :content, locals: {post: post}, type: 'html'
          x.updated   to_xs_date_time post[:updated_at]
          x.author    { x.name username }
        }
      end
    }

  end
end

not_found do
  "Forrst user not found. Try: #{url("/kyle")}"
end

def to_xs_date_time(time)
  DateTime.parse(time.to_s).strftime('%Y-%m-%dT%H:%M:%S%z').insert(-3, ':')
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
