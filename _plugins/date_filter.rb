require 'date'

module Jekyll
  module EscalaDataFilter
    def proximas_datas(dias_array, custom_limit = nil)
      return [] unless dias_array.is_a?(Array)

      site_config = @context.registers[:site].config
      limite = custom_limit || site_config['quantidade_dias_padrao'] || 8

      # 1. Ajuste do 'Hoje': Agora pegamos apenas a data YYYY-MM-DD
      # Usamos Date.today para não depender de horas/minutos
      hoje = Time.now.getlocal('-03:00').strftime('%Y-%m-%d')

      proximas = dias_array
                   .select { |item| 
                     # Garante que estamos comparando strings no mesmo formato
                     # Ex: "2026-02-24" >= "2026-02-06"
                     item['data'] >= hoje 
                   }
                   .sort_by { |item| item['data'] }
                   .first(limite.to_i)

      proximas
    end
  end
end

Liquid::Template.register_filter(Jekyll::EscalaDataFilter)
