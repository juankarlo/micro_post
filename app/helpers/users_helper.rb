module UsersHelper
#  Returns the Gravatar for the given user
  def gravatar_for(user, options = {size: 50, shape: '' })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    shape = options[:shape]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
   # TODO: Change later the stub for the gravatar
    # image_tag(gravatar_url, alt: user.name, class: "gravatar #{shape}")
    image_tag('gravatar.png', alt: user.name, class: "gravatar #{shape}")
  end
end
