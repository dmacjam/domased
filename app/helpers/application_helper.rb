module ApplicationHelper

  # Vrati cely nazov stranky pre kazdu podstranku.
  def full_title(page_title)
    base_title='Domased'
    if page_title.nil?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  #Render error massages partial.
  def error_messages_for(object)
    render(:partial => 'application/error_messages',
           :locals => {:object => object})
  end


end
