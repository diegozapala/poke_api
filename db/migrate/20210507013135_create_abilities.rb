class CreateAbilities < ActiveRecord::Migration[6.1]
  def change
    create_table :abilities do |t|
      t.references :pokemon, foreign_key: true, index: true
      t.string     :name, default: ""
      t.text       :description, default: ""

      t.timestamps
    end
  end
end
