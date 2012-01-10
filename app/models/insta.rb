class Insta
  def self.media_popular
    res = InstaCache.get('popular')
    if res
      return res
    end

    res = Instagram.media_popular
    InstaCache.set('popular', res)
    res
  end

  def self.user_find_by_username(access_token, username)
    key = sprintf("user_find_by_username_%s_%s", access_token, username)
    res = InstaCache.get(key)
    if res
      return res
    end

    client = Instagram.client(:access_token => access_token)
    results = client.user_search(username)
    results.each do |result|
      if result["username"] == username
        user = self.user(access_token, result["id"])
        if user
          InstaCache.set(key, user)
          return user
        else
          InstaCache.set(key, user)
          return result
        end
      end
    end
    return
  end

  def self.user(access_token, id)
    key = sprintf("user_%s_%s", access_token, id)
    res = InstaCache.get(key)
    if res
      return res
    end

    client = Instagram.client(:access_token => access_token)
    res = client.user(id)
    InstaCache.set(key, res)
    res
  end

  def self.user_recent_media(access_token, user_id, options)
    key = sprintf("user_recent_media_%s_%s_%s", access_token, user_id, options[:max_id])
    res = InstaCache.get(key)
    if res
      return res
    end

    client = Instagram.client(:access_token => access_token)
    res = client.user_recent_media(user_id, options)
    InstaCache.set(key, res)
    res
  end

  def self.user_media_feed(access_token, options)
    key = sprintf("user_media_feed_%s_%s", access_token, options[:max_id])
    res = InstaCache.get(key)
    if res
      return res
    end

    client = Instagram.client(:access_token => access_token)
    res = client.user_media_feed(options)
    InstaCache.set(key, res)
    res
  end

  def self.like_media(access_token, id)
    key = sprintf("media_likes_%s", id)
    InstaCache.delete(key)

    key = sprintf("media_item_%s_%s", access_token, id)
    InstaCache.delete(key)

    key = sprintf("user_has_liked_%s_%s", access_token, id)
    InstaCache.set(key, 1)

    client = Instagram.client(:access_token => access_token)
    client.like_media(id)
  end

  def self.unlike_media(access_token, id)
    key = sprintf("media_likes_%s", id)
    InstaCache.delete(key)

    key = sprintf("media_item_%s_%s", access_token, id)
    InstaCache.delete(key)

    key = sprintf("user_has_liked_%s_%s", access_token, id)
    InstaCache.delete(key)

    client = Instagram.client(:access_token => access_token)
    client.unlike_media(id)    
  end

  def self.media_item(access_token, id)
    key = sprintf("media_item_%s_%s", access_token, id)
    res = InstaCache.get(key)
    if res
      return res
    end

    client = Instagram.client(:access_token => access_token)
    res = client.media_item(id)    
    InstaCache.set(key, res)
    res
  end

  def self.media_likes(access_token=nil, id)
    key = sprintf("media_likes_%s", id)
    res = InstaCache.get(key)
    if res
      return res
    end

    client = Instagram.client(:access_token => access_token)
    res = client.media_likes(id)    
    InstaCache.set(key, res)
    res
  end

  def self.media_comments(access_token, id)
    key = sprintf("media_comments_%s", id)
    res = InstaCache.get(key)
    if res
      return res
    end

    client = Instagram.client(:access_token => access_token)
    res = client.media_comments(id)    
    InstaCache.set(key, res)
    res
  end

  def self.create_media_comment(access_token, id, text) 
    key = sprintf("media_comments_%s", id)
    InstaCache.delete(key)

    client = Instagram.client(:access_token => access_token)
    client.create_media_comment(id, text)
  end

  def self.user_follows(access_token, id, options)
    client = Instagram.client(:access_token => access_token)
    client.user_follows(id, options)
  end

  def self.user_relationship(access_token, id)
    client = Instagram.client(:access_token => access_token)
    client.user_relationship(id)
  end

  def self.user_liked_media(access_token, options)
    key = sprintf("user_liked_media_%s_%s", access_token, options[:max_like_id])
    res = InstaCache.get(key)
    if res
      return res
    end

    client = Instagram.client(:access_token => access_token)
    res = client.user_liked_media(options)
    InstaCache.set(key, res)
    res
  end

  def self.follow_user(access_token, id)
    client = Instagram.client(:access_token => access_token)
    client.follow_user(id)
  end

  def self.unfollow_user(access_token, id)
    client = Instagram.client(:access_token => access_token)
    client.unfollow_user(id)
  end

  def self.tag_recent_media(tagname, options)
    key = sprintf("tag_recent_media_%s_%s", tagname, options[:max_tag_id])
    res = InstaCache.get(key)
    if res
      return res
    end

    res = Instagram.tag_recent_media(tagname, options)
    InstaCache.set(key, res)
    res
  end

end
