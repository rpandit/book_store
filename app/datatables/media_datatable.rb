class MediaDatatable
  delegate :params, :h, :link_to, :number_to_currency, :edit_medium_path, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Medium.count,
      iTotalDisplayRecords: media.total_entries,
      aaData: data
    }
  end

private

  def data
    media.map do |medium|
      [
        h(medium.id),
        link_to(medium.title, medium),
        h(medium.author),
        h(medium.publisher),
        h(medium.category),
        link_to('Edit', edit_medium_path(medium)),
        link_to('Destroy', medium, method: :delete, data: { confirm: 'Are you sure?' }),
      ]
    end
  end

  def media
    media ||= fetch_media
  end

  def fetch_media
    media = Medium.order("#{sort_column} #{sort_direction}")
    media = media.page(page).per_page(per_page)
    if params[:sSearch].present?
      media = media.where("title like :search or author like :search or publisher like :search  or category like :search", 
      search: "%#{params[:sSearch]}%")
    end
    media
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[title author publisher category]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
