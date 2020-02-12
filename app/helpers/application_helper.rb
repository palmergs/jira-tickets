module ApplicationHelper
  def unknown? k
    return 'Unknown' if k.nil?
    return 'Empty' if k.is_a?(Array) && k.empty?
    return 'Unknown' if k.blank?
    k.to_s
  end
end
