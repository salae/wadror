class MoveStyleDataToStyleTable < ActiveRecord::Migration
  def change
    rename_column :beers, :style, :old_style
    add_column :beers, :style_id, :integer
    

    Style.create name: "Weizen"
    Style.create name: "Lager"
    Style.create name: "Pale Ale"
    Style.create name: "IPA"
    Style.create name: "Porter"
    Style.create name: "lowalcohol"

  end
end
