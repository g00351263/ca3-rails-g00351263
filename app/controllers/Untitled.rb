@all_ratings = Movie.all_ratings
@selected_ratings = (params[:ratings] || Hash[@all_ratings.product([1])]).keys
@header_classes = {'title': '', 'release_date': ''}
@header_classes[params[:sort]] = 'hilite'
@movies = Movie.where(rating: @selected_ratings).order(params[:sort])    
# @movies = Movie.all.order(params[:sort])

def self.all_ratings
    ['G','PG','PG-13','R']
end

      %th{class: @header_classes['title']}= link_to 'Movie Title', movies_path(:sort => 'title'), :id => 'title_header'
      %th{class: @header_classes['release_date']}= link_to 'Release Date', movies_path(sort: 'release_date'), id: 'release_date_header'

      
= form_tag movies_path, :method => :get do
  Include:
  - @all_ratings.each do |rating|
    = rating
    = check_box_tag "ratings[#{rating}]", 1, @selected_ratings.include?(rating), :id => "ratings_#{rating}"    
  = submit_tag 'Refresh'