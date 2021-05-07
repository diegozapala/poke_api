class PokemonController < ApplicationController

  def get_poke
    if !find_pokemon && poke_response_ok?
      build_pokemon
      build_abilities
    elsif !find_pokemon
      response = 'Não encontrado'
    end

    response = response || find_pokemon.abilities.order(name: :asc).map do |ability|
                             {ability.name => ability.description}
                           end

    json_response(response)
  end

  private

  def find_pokemon
    @find_pokemon ||= Pokemon.find_by(name: params[:name])
  end

  def build_pokemon
    @build_pokemon = Pokemon.create(name: params[:name])
  end

  def build_abilities
    poke_response_poke["abilities"].map do |poke|
      poke_request = poke_api_request_ability(poke["ability"]["url"])
      ability_details = poke_response_ability(poke_request)

      ability_name = poke["ability"]["name"]
      ability_description = ability_details["effect_entries"][1]["effect"]

      Ability.create(pokemon: @build_pokemon, name: ability_name, description: ability_description)
    end
  end

  def context
    "pokemon"
  end

  def context_with_params
    "#{context}/#{params[:name]}"
  end

  def get_url
    @get_url ||= PokeApiRequest.get_url(context_with_params)
  end

  def poke_api_request_poke
    @poke_api_request_poke ||= PokeApiRequest.new(api_url: get_url)
  end

  def poke_response_ok?
    poke_api_request_poke.response_ok?
  end

  def poke_response_poke
    poke_api_request_poke.response_body
  end




  def poke_api_request_ability(ability_url)
    @poke_api_request_ability = PokeApiRequest.new(api_url: ability_url)
  end

  def poke_response_ability(ability_request)
    ability_request.response_body
  end

end
