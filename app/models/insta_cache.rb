require 'memcache'

class InstaCache
  @@cache = MemCache.new(MEMCACHE_SERVERS)

  def self.get(key)
    @@cache.get(key)
  end

  def self.set(key, value, expires=300)
    @@cache.set(key, value, expires)
  end

  def self.delete(key)
    @@cache.delete(key)
  end

end
