module UsersHelper
  def avatar_for(user, size: 80)
    if user.avatar.attached?
      image_tag user.avatar, alt: user.username, class: "user-avatar", width: size, height: size
    else
      gravatar_for(user, size: size)
    end
  end
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "gravatar")
  end
end
