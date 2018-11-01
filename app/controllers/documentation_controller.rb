class DocumentationController < ApplicationController
  before_action :set_page_title, only: :show

  def index
    @docs = Dir.glob("#{Rails.root}/docs/**/*.md").sort
  end

  def show
    file = File.basename(params[:id])
    doc = "#{Rails.root}/docs/#{file}.md"
    @doc = parsed_doc(doc)
  end

  private

  def parsed_doc(doc)
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      tables: true,
      fenced_code_blocks: true
    )
    markdown.render(File.read(doc))
  end

  def set_page_title
    @page_title = "Documentation - #{params[:id].to_s.capitalize}"
  end
end
