require 'date'

module Jekyll
  module EscalaDataFilter
    def proximas_datas(dias_array, custom_limit = nil)
      return [] unless dias_array.is_a?(Array)

      # Acessa as configurações globais do site através do contexto do Liquid
      site_config = @context.registers[:site].config
      
      # Lógica de prioridade: 
      # 1. Valor passado no HTML (| proximas_datas: 5)
      # 2. Valor no _config.yml (quantidade_escalas_padrao)
      # 3. Valor fixo 8 (fallback)
      limite = custom_limit || site_config['quantidade_dias_padrao'] || 8

      hoje = Time.now.strftime('%Y-%m-%dT%H:%M:%S.000Z')

      proximas = dias_array
                   .select { |item| item['data'] >= hoje }
                   .sort_by { |item| item['data'] }
                   .first(limite.to_i) # Garante que seja um inteiro

      proximas
    end
  end
end

Liquid::Template.register_filter(Jekyll::EscalaDataFilter)
