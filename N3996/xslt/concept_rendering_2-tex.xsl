<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:str="http://exslt.org/strings"
  xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="str exsl"
>
<xsl:strip-space elements="desc"/>

<xsl:output method="text"/>

<xsl:template name="nl">
<xsl:text>&#xA;</xsl:text>
</xsl:template>

<xsl:template match="*">
</xsl:template>

<xsl:template name="get-concept-bases">
  <xsl:param name="concept_name"/>

  <xsl:for-each select="/concepts/concept[@name=$concept_name]/is_a">
    <xsl:call-template name="get-concept-bases">
      <xsl:with-param name="concept_name" select="@concept"/> 
    </xsl:call-template>
  </xsl:for-each>

  <xsl:for-each select="/concepts/concept[@name=$concept_name]/may_be">
    <xsl:call-template name="get-concept-bases">
      <xsl:with-param name="concept_name" select="@concept"/> 
    </xsl:call-template>
  </xsl:for-each>

  <xsl:text>[</xsl:text>
  <xsl:value-of select="$concept_name"/>
  <xsl:text>]</xsl:text>
</xsl:template>

<xsl:template name="mangle-name">
  <xsl:param name="name"/>
  <xsl:value-of select="$name"/>
  <xsl:if test="/concepts/keywords/kw[text()=$name]">
    <xsl:text>_</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template name="process-getter">
  <xsl:param name="concept_name" select="../@name"/>

  <xsl:text>template &lt;</xsl:text>
  <xsl:if test="../@parameter">
    <xsl:text>typename </xsl:text>
    <xsl:value-of select="../@parameter"/>
  </xsl:if>
  <xsl:if test="name(.)='element'">
    <xsl:if test="../@parameter">
      <xsl:text>, </xsl:text>
    </xsl:if>
    <xsl:text>size_t Index</xsl:text>
  </xsl:if>
  <xsl:if test="name(.)='template'">
    <xsl:for-each select="parameter">
      <xsl:choose>
        <xsl:when test="@unspecified_type">
          <xsl:text>typename </xsl:text>
        </xsl:when>
      </xsl:choose>
      <xsl:call-template name="mangle-name">
        <xsl:with-param name="name" select="@name"/>
      </xsl:call-template>
      <xsl:if test="position() != last() and not(following-sibling::parameters)">
        <xsl:text>, </xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:if test="parameters">
      <xsl:text>...</xsl:text>
    </xsl:if>
  </xsl:if>
  <xsl:text>&gt;</xsl:text>
  <xsl:call-template name="nl"/>

  <xsl:text>struct </xsl:text>
  <xsl:call-template name="mangle-name">
    <xsl:with-param name="name" select="@name"/>
  </xsl:call-template>
 
  <xsl:text>&lt;</xsl:text>
  <xsl:value-of select="$concept_name"/>
  <xsl:if test="../@parameter">
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="../@parameter"/>
    <xsl:text>&gt;</xsl:text>
  </xsl:if>
  <xsl:if test="name(.)='element'">
    <xsl:text>, integral_constant&lt;size_t, Index&gt;</xsl:text>
  </xsl:if>

  <xsl:if test="name(.)='template'">
    <xsl:for-each select="parameter">
      <xsl:text>, </xsl:text>
      <xsl:choose>
        <xsl:when test="@unspecified_type">
        </xsl:when>
      </xsl:choose>
      <xsl:call-template name="mangle-name">
        <xsl:with-param name="name" select="@name"/>
      </xsl:call-template>
    </xsl:for-each>
    <xsl:if test="parameters">
      <xsl:text>, </xsl:text>
      <xsl:text>...</xsl:text>
    </xsl:if>
  </xsl:if>
  <xsl:text>&gt;</xsl:text>
  <xsl:call-template name="nl"/>
  <xsl:if test="name(.)='attribute' and @constant and @integral='true'">
    <xsl:text> : integral_constant&lt;</xsl:text>
    <xsl:value-of select="@constant"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="@value"/>
    <xsl:text>&gt;</xsl:text>
    <xsl:call-template name="nl"/>
  </xsl:if>
  <xsl:text>{</xsl:text>

  <xsl:choose>
    <xsl:when test="name(.)='attribute' and @constant and not(@integral='true')">
      <xsl:call-template name="nl"/>
      <xsl:text>  static constexpr </xsl:text>
      <xsl:value-of select="@constant"/>
      <xsl:text> value;</xsl:text>
      <xsl:call-template name="nl"/>
    </xsl:when>

    <xsl:when test="name(.)='attribute' and (@unspecified_type or @concept or @placeholder)">
      <xsl:call-template name="nl"/>
      <xsl:text>  typedef </xsl:text>
      <xsl:value-of select="@unspecified_type"/>
      <xsl:value-of select="@concept"/>
      <xsl:value-of select="@placeholder"/>
      <xsl:text> type;</xsl:text>
      <xsl:call-template name="nl"/>
    </xsl:when>

    <xsl:when test="name(.)='range'">
      <xsl:call-template name="nl"/>
      <xsl:text>  typedef </xsl:text>
      <xsl:value-of select="@concept"/>
      <xsl:text>&lt;</xsl:text>
      <xsl:value-of select="@argument"/>
      <xsl:text>&gt;</xsl:text>
      <xsl:text> type;</xsl:text>
      <xsl:call-template name="nl"/>
    </xsl:when>

    <xsl:when test="name(.)='element'">
      <xsl:call-template name="nl"/>
      <xsl:text>  typedef </xsl:text>
      <xsl:value-of select="@concept"/>
      <xsl:value-of select="@placeholder"/>
      <xsl:value-of select="@unspecified_type"/>
      <xsl:text> type;</xsl:text>
      <xsl:call-template name="nl"/>
    </xsl:when>


    <xsl:when test="name(.)='template'">
      <xsl:call-template name="nl"/>
      <xsl:text>  typedef </xsl:text>
      <xsl:value-of select="@concept"/>
      <xsl:value-of select="@unspecified_type"/>
      <xsl:text> type;</xsl:text>
      <xsl:call-template name="nl"/>
    </xsl:when>

    <xsl:when test="name(.)='function'">
      <xsl:call-template name="nl"/>
      <xsl:text>  static </xsl:text>
      <xsl:value-of select="@unspecified_type"/>
      <xsl:text> </xsl:text>
      <xsl:text>apply(</xsl:text>
      <xsl:for-each select="parameter">
        <xsl:choose>
          <xsl:when test="@unspecified_type">
            <xsl:value-of select="@unspecified_type"/>
            <xsl:text> </xsl:text>
          </xsl:when>
        </xsl:choose>
        <xsl:call-template name="mangle-name">
          <xsl:with-param name="name" select="@name"/>
        </xsl:call-template>
        <xsl:if test="position() != last() and not(following-sibling::parameters)">
          <xsl:text>, </xsl:text>
        </xsl:if>
      </xsl:for-each>
      <xsl:if test="parameters">
        <xsl:text>...</xsl:text>
      </xsl:if>

      <xsl:text>);</xsl:text>
      <xsl:call-template name="nl"/>
    </xsl:when>
    <xsl:otherwise><xsl:text> </xsl:text></xsl:otherwise>
  </xsl:choose>
  <xsl:text>};</xsl:text>
  <xsl:call-template name="nl"/>
</xsl:template>

<xsl:template name="process-inherited">
  <xsl:param name="concept_name"/>
  <xsl:param name="optional" select="false"/>
  <xsl:param name="parent_already_done"/>

  <xsl:for-each select="is_a|may_be">
    <xsl:variable name="base_name" select="@concept"/>
    <xsl:variable name="may_be" select="name(.) = 'may_be'"/>

    <xsl:variable name="already_done">
      <xsl:value-of select="$parent_already_done"/>
      <xsl:for-each select="preceding-sibling::is_a|preceding-sibling::may_be">
        <xsl:call-template name="get-concept-bases">
          <xsl:with-param name="concept_name" select="@concept"/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:variable>

    <xsl:if test="not(contains($already_done, concat('[', $base_name, ']')))">
      <xsl:for-each select="/concepts/concept[@name=$base_name]">
        <xsl:call-template name="process-inherited">
          <xsl:with-param name="concept_name" select="$concept_name"/>
          <xsl:with-param name="optional" select="$optional or $may_be"/>
          <xsl:with-param name="parent_already_done" select="$already_done"/>
        </xsl:call-template>
      </xsl:for-each>

      <xsl:for-each select="/concepts/concept[@name=$base_name]">
        <xsl:for-each select="attribute|element|function|template|range">
          <xsl:variable name="member_name" select="@name"/>
          <xsl:if test="$member_name != 'category' and not(/concepts/concept[@name=$concept_name]/node()/@name=$member_name)">
            <xsl:text>  // </xsl:text>
            <xsl:if test="$optional or $may_be">
              <xsl:text>possibly </xsl:text>
            </xsl:if>
            <xsl:text>inherited from </xsl:text>
            <xsl:value-of select="$base_name"/>
            <xsl:call-template name="nl"/>
            <xsl:call-template name="process-getter">
              <xsl:with-param name="concept_name" select="$concept_name"/>
            </xsl:call-template>
            <xsl:call-template name="nl"/>
          </xsl:if>
        </xsl:for-each>
      </xsl:for-each>
    </xsl:if>
  </xsl:for-each>
</xsl:template>

<xsl:template match="/concepts">

<xsl:text>
\subsection{Concept models -- variant 2 (alternative)}
\label{appendix-alternative-concept-rendering}
</xsl:text>

  <xsl:for-each select="concept">

    <xsl:variable name="concept_name" select="@name"/>

    <xsl:text>\subsubsection{</xsl:text>
    <xsl:value-of select="@name"/>
    <xsl:text>}</xsl:text>
    <xsl:call-template name="nl"/>

    <xsl:choose>
      <xsl:when test="@kind='tag'">

        <xsl:text>This concept has the following instances:</xsl:text>
        <xsl:text>\begin{minted}{cpp}</xsl:text>
        <xsl:call-template name="nl"/>

        <xsl:for-each select="instance">
          <xsl:text>struct </xsl:text>
          <xsl:value-of select="concat(../@prefix,'_', @name, '_tag')"/>
          <xsl:text> { };</xsl:text>
          <xsl:call-template name="nl"/>

        </xsl:for-each>
        <xsl:text>\end{minted}</xsl:text>
        <xsl:call-template name="nl"/>

      </xsl:when>
      <xsl:otherwise>
        <xsl:text>\begin{minted}{cpp}</xsl:text>
        <xsl:call-template name="nl"/>

        <xsl:if test="@parameter">
          <xsl:text>template &lt;typename </xsl:text>
          <xsl:value-of select="@parameter"/>
          <xsl:text>&gt;</xsl:text>
          <xsl:call-template name="nl"/>
        </xsl:if>

        <xsl:text>struct </xsl:text>
        <xsl:call-template name="mangle-name">
          <xsl:with-param name="name" select="@name"/>
        </xsl:call-template>

        <xsl:text> { };</xsl:text>
        <xsl:call-template name="nl"/>
        <xsl:call-template name="nl"/>

        <xsl:if test="/concepts/concept[@name='MetaobjectCategory' and @name != $concept_name]/instance[@indicates=$concept_name]">
          <xsl:for-each select="/concepts/concept[@name='MetaobjectCategory' and @name != $concept_name]/instance[@indicates=$concept_name]">
            <xsl:text>template typename &lt;&gt;</xsl:text>
            <xsl:call-template name="nl"/>

            <xsl:text>struct category</xsl:text>
            <xsl:text>&lt;</xsl:text>
            <xsl:call-template name="mangle-name">
              <xsl:with-param name="name" select="$concept_name"/>
            </xsl:call-template>
            <xsl:text>&gt;</xsl:text>
            <xsl:call-template name="nl"/>

            <xsl:text>{</xsl:text>
            <xsl:call-template name="nl"/>
            <xsl:text>  typedef </xsl:text>
            <xsl:value-of select="concat(../@prefix,'_',@name,'_tag')"/>
            <xsl:text> type;</xsl:text>
            <xsl:call-template name="nl"/>
            <xsl:text>};</xsl:text>
            <xsl:call-template name="nl"/>
          </xsl:for-each>
          <xsl:if test="attribute|element|function|template|range">
            <xsl:call-template name="nl"/>
          </xsl:if>
        </xsl:if>

        <xsl:call-template name="process-inherited">
          <xsl:with-param name="concept_name" select="$concept_name"/>
        </xsl:call-template>

        <xsl:for-each select="attribute|element|function|template|range">
          <xsl:call-template name="process-getter"/>
          <xsl:if test="position() != last()">
            <xsl:call-template name="nl"/>
          </xsl:if>
        </xsl:for-each>

        <xsl:call-template name="nl"/>

        <xsl:for-each select="trait">
          <xsl:text>template &lt;&gt;</xsl:text>
          <xsl:call-template name="nl"/>
          <xsl:text>struct </xsl:text>
          <xsl:call-template name="mangle-name">
            <xsl:with-param name="name" select="@name"/>
          </xsl:call-template>
          <xsl:text>&lt;</xsl:text>
          <xsl:value-of select="$concept_name"/>
          <xsl:text>&gt;</xsl:text>
          <xsl:call-template name="nl"/>
          <xsl:if test="@constant">
            <xsl:text> : integral_constant&lt;</xsl:text>
            <xsl:value-of select="@constant"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="@value"/>
            <xsl:text>&gt;</xsl:text>
            <xsl:call-template name="nl"/>
            <xsl:text>{ };</xsl:text>
          </xsl:if>
          <xsl:if test="@concept">
            <xsl:text>{</xsl:text>
            <xsl:call-template name="nl"/>
            <xsl:text>  typedef </xsl:text>
            <xsl:value-of select="@concept"/>
            <xsl:text> type;</xsl:text>
            <xsl:call-template name="nl"/>
            <xsl:text>};</xsl:text>
          </xsl:if>
          <xsl:call-template name="nl"/>

          <xsl:call-template name="nl"/>
        </xsl:for-each>

        <xsl:for-each select="/concepts/concept[@name='Metaobject' and @name != $concept_name]/trait[@indicates=$concept_name]">
          <xsl:text>template &lt;&gt;</xsl:text>
          <xsl:call-template name="nl"/>
          <xsl:text>struct </xsl:text>
          <xsl:call-template name="mangle-name">
            <xsl:with-param name="name" select="@name"/>
          </xsl:call-template>
          <xsl:text>&lt;</xsl:text>
          <xsl:value-of select="$concept_name"/>
          <xsl:text>&gt;</xsl:text>
          <xsl:call-template name="nl"/>
          <xsl:text> : integral_constant&lt;bool, true&gt;</xsl:text>
          <xsl:call-template name="nl"/>
          <xsl:text>{ };</xsl:text>
          <xsl:call-template name="nl"/>

          <xsl:call-template name="nl"/>
        </xsl:for-each>

        <xsl:text>\end{minted}</xsl:text>
        <xsl:call-template name="nl"/>

      </xsl:otherwise>
    </xsl:choose>

  </xsl:for-each>

</xsl:template>

</xsl:stylesheet>
