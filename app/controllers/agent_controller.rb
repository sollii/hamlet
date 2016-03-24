class AgentController < ApplicationController

  def index
    gon.conversation_modules = load_modules(["onboarding"])
  end

  def get_module_JSON(name)
    module_path = "#{Rails.root}/lib/conversation_modules/#{name}.yml"
    JSON.parse(YAML::parse_file(module_path).to_ruby.to_json)
  end

  def load_modules(modules)
    dict = {}
    for m in modules
      dict[m] = get_module_JSON m
    end
    return dict
  end

end
