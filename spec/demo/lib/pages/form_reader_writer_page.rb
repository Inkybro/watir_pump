# frozen_string_literal: true

require 'watir_pump'

class FormReaderWriterPage < WatirPump::Page
  uri '/form.html'

  text_field_writer :name, name: 'name'
  # custom_writer :name, ->(v) { root.text_field(name: 'name').set(v) }
  span_reader :name, id: 'res_name'

  textarea_writer :description, name: 'description'
  span_reader :description, id: 'res_description'

  radio_writer :gender, name: 'gender'
  span_reader :gender, id: 'res_gender'

  radio_group :predicate, name: 'predicate'
  span_reader :predicate, id: 'res_predicate'

  flag_writer :confirmed, name: 'confirmation'
  custom_reader :confirmed, -> { root.span(id: 'res_confirmation').text == 'YES' }

  checkbox_writer :hobbies, name: 'hobbies[]'
  custom_reader :hobbies
  query :hobbies, -> { split_span('res_hobbies') }

  checkbox_writer :continents, name: 'continents[]'
  custom_reader :continents, -> { split_span('res_continents') }

  select_writer :car, name: 'car'
  span_reader :car, id: 'res_car'

  select_writer :ingredients, name: 'ingredients[]'
  custom_reader :ingredients

  button_clicker :submit, id: 'generate'

  query :split_span, ->(id) { root.span(id: id).text.split(', ') }

  def ingredients
    root.ul(id: 'res_ingredients')&.lis&.map(&:text) || []
  end
end
