class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.string     :name, default: ""

      t.timestamps
    end
  end
end
