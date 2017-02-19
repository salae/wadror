class MoveStyleDataToStyleTablePartTwo < ActiveRecord::Migration
  def change
    # not working!
      Beer.all.each do |beer|
      s = Style.find_by name: beer.old_style
      #byebug
      beer.style_id=s.id
      beer.save
    end

    remove_column :beers, :old_style
  end
end
