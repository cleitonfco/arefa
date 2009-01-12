# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def show_status(status)
    image = status ? 'private.png' : 'public.png'
    text = status ? 'Projeto privado' : 'Projeto público'
    format("<img alt=\"%s\" title=\"%s\" src=\"/images/%s\" />", text, text, image)
  end

  def show_mark_as_done(done)
    done ? '<p class="reopen">Concluído. <a href="#">Re-abrir</a></p>' : '<p class="done"><a href="#">Marcar como concluído</a></p>'
  end

  def show_feedback(feedback)
    feedback ? '<p class="nofeedback"><a href="#">Cancelar feedback</a></p>' : '<p class="feedback"><a href="#">Pedir Feedback</a></p>'
  end

  def show_priority(priority)
    images = %w(low normal high)
    texts = %w(Baixa Normal Alta).map {|t| "Prioridade #{t}" }
    format("<img alt=\"%s\" title=\"%s\" src=\"/images/%s\" />", texts[priority], texts[priority], images[priority].concat('.png'))
  end

  def page_title
    @title ? "#{strip_tags(@title)} - Arefa" : "Arefa"
  end
end
