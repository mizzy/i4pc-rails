module ApplicationHelper
  def convert_emoji(text)
    return nil if text.nil?
    result = ''
    space = '&nbsp;'
    text.each_char do |c|
      if c >= "\uE001" && c <= "\uE537"
        unicode = format('%x', c.unpack('U').first)
        result += "<span class=\"emoji emoji_#{unicode}\">#{space}</span>"
      else
        result += c
      end
    end
    result
  end
end
