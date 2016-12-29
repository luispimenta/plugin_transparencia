<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
Formata o XML que deve ser exportado para exibir dados que visam dar
transparência às contas públicas - Lei Complementar 131.

Versão: 1.01
Autor: Cristiano Yamashita
Data: 11/05/2010
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:decimal-format name="ptBR" decimal-separator=',' grouping-separator='.' />
<xsl:output method="html"/>
  <xsl:template match="/">
    <html>
      <head>
        <title>Transparência</title>
        <style>
          body { font-family: Arial; font-size: 12px; background-color: white; font-weight: normal; }
          td { font-size: 12px; }

          .titulo_empresa { color: black; font-size: 20px; font-weight: bold; margin-bottom: 20px; }
          .titulo_principal { color: navy; font-size: 18px; font-weight: bold; margin-bottom: 8px; }
          .texto { margin-bottom: 20px; }
          .rodape { font-size: 10px; }
          .titulo_detalhe { color: black; font-weight: bold; background-color: lightgrey }
          .nome_credor { color: black; font-weight: bold; padding-top: 10px}
          .detalhe { color: black; }
          .titulo_categoria { font-size: 16px; color: #336699; font-weight: bold; margin-bottom: 8px; padding-top: 15px }
          .titulo_credor { font-size: 14px; color: #3366CC; font-weight: bold; padding-top: 15px }
          .tabela1 { padding: 2px; background-color: whitesmoke; }
          .tabela2 { padding: 2px; background-color: white; }
          #cabecalho { padding: 5px}
        </style>
      </head>

      <body>

        <!-- HTML -->
        <div id="cabecalho">
        <div class="titulo_empresa"><xsl:value-of select="doc/entidade/nome" /></div>
        <div class="titulo_principal">Portal da Transparência</div>
        <div class="texto">Em atendimento à Lei Complementar 131 que visa dar transparência às contas públicas.</div>
        </div>
        <div class="titulo_categoria">Data: <xsl:value-of select="doc/entidade/data" /></div>
        <div class="titulo_categoria">Receitas</div>
        <table class="tabela1" style="width: 850">
          <tr>
            <td class="titulo_detalhe" style="width: 150px">Classificação</td>
            <td class="titulo_detalhe" style="width: 400px">Rubrica</td>
            <td class="titulo_detalhe" style="width: 100px; text-align: right">Orçado</td>
            <td class="titulo_detalhe" style="width: 100px; text-align: right">Realizado</td>
          </tr>
          <xsl:for-each select="doc/receitas/receita">
            <tr>
              <td class="detalhe">
                <xsl:value-of select="codigo"/>
              </td>
              <td class="detalhe">
                <xsl:value-of select="titulo"/>
              </td>
              <td class="detalhe" style="text-align: right">
                <xsl:value-of select='format-number(previsto, "###.##0,00", "ptBR")' />
              </td>
              <td class="detalhe" style="text-align: right">
                <xsl:value-of select='format-number(realizado, "###.##0,00", "ptBR")' />
              </td>
            </tr>
          </xsl:for-each>
        </table>
        <hr/>
        <div class="titulo_categoria">Despesas</div>
        <table class="tabela1" style="WIDTH: 850px">
          <tr>
            <td class="titulo_detalhe" style="width: 150px">Classificação</td>
            <td class="titulo_detalhe" style="width: 500px">Título</td>
            <td class="titulo_detalhe" style="width: 100px; text-align: right">Previsto</td>
            <td class="titulo_detalhe" style="width: 100px; text-align: right">Liquidado</td>
          </tr>
          <xsl:for-each select="doc/despesas/despesa">
            <tr>
              <td class="detalhe">
                <xsl:value-of select="codigo"/>
              </td>
              <td class="detalhe">
                <xsl:value-of select="titulo"/>
              </td>
              <td class="detalhe" style="text-align: right">
                <xsl:value-of select='format-number(previsto, "###.##0,00", "ptBR")' />
              </td>
              <td class="detalhe" style="text-align: right">
                <xsl:value-of select='format-number(liquidado, "###.##0,00", "ptBR")' />
              </td>
            </tr>
          </xsl:for-each>
        </table>
        <hr/>
        <div class="titulo_categoria">Despesas Liquidadas</div>
        <table class="tabela2" width="800px">
          <xsl:for-each select="doc/despesas/despesa">
          <tr>
            <td colspan="5" class="titulo_credor" style="width: 800px"><xsl:value-of select="codigo"/> - <xsl:value-of select="titulo"/></td>
          </tr>
          <xsl:for-each select="credores/credor">
          <tr>
            <td colspan="5" class="nome_credor" style="width: 800px"><xsl:value-of select="fornecedor/razao_social"/></td>
          </tr>
          <tr>
            <td class="detalhe" style="width: 150px"><xsl:value-of select="fornecedor/cnpj"/></td>
            <td class="detalhe" style="width: 150px"><xsl:value-of select="modalidade"/></td>
            <td class="detalhe" style="width: 150px"><xsl:value-of select="processo"/></td>
            <td class="detalhe" style="width: 100px"><xsl:value-of select="Detalhe_Despesa"/></td>
            <td class="detalhe" style="width: 050px"><xsl:value-of select="Fonte_Rec"/></td>
            <td class="detalhe" style="width: 150px; text-align: right"><xsl:value-of select='format-number(valor_liquidado, "###.##0,00", "ptBR")'/></td>
            <td class="detalhe" style="width: 050px; text-align: right"></td>
          </tr>
          <tr>
            <td colspan="5" class="detalhe"><xsl:value-of select="descricao"/></td>
          </tr>
          </xsl:for-each>

            <!-- >tr><td colspan="5" style="width: 800px">-</td></tr -->
          </xsl:for-each>
        </table>
        <hr/>
	      <br/>
        <div class="rodape">Atualizado em <xsl:value-of select="doc/entidade/datafim" /></div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>