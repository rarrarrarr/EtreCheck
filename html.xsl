<?xml version="1.0"?>
<xsl:stylesheet 
  version='1.0' 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:my="http://etresoft.com/etrecheck/byte_units"
  exclude-result-prefixes="my">

  <!-- Convert an EtreCheck report into an HTML representation. -->
  <!-- TODO: Add a parameter for localization and localize with language-specific XML files. -->
  <xsl:output method="html" indent="yes" encoding="UTF-8"/> 
 
  <my:units>
    <unit>B</unit>
    <unit>KB</unit>
    <unit>MB</unit>
    <unit>GB</unit>
    <unit>TB</unit>
    <unit>PB</unit>
  </my:units>
  
  <xsl:variable name="byte_units" select="document('')//my:units/unit"/>

  <xsl:template match='/etrecheck'>
  
    <html>
    
      <head>
        <title>EtreCheck Report</title>
      </head>

      <body>
      
        <!-- TODO: Break this out. -->
        <xsl:apply-templates select="stats"/>
        <xsl:apply-templates select="problem"/>
        <xsl:apply-templates select="hardware"/>
        <xsl:apply-templates select="video"/>
        <xsl:apply-templates select="systemsoftware"/>
        <xsl:apply-templates select="disk"/>
        <xsl:apply-templates select="usb"/>
        <xsl:apply-templates select="firewire"/>
        <xsl:apply-templates select="thunderbolt"/>
        <xsl:apply-templates select="configurationfiles"/>
        <xsl:apply-templates select="gatekeeper"/>
        <xsl:apply-templates select="adware"/>
        <xsl:apply-templates select="unknownfiles"/>
        <xsl:apply-templates select="kernelextensions"/>
        <xsl:apply-templates select="startupitems"/>
        <xsl:apply-templates select="systemlaunchagents"/>
        <xsl:apply-templates select="systemlaunchdaemons"/>
        <xsl:apply-templates select="launchagents"/>
        <xsl:apply-templates select="launchdaemons"/>
        <xsl:apply-templates select="userlaunchagents"/>
        <xsl:apply-templates select="loginitems"/>
        <xsl:apply-templates select="internetplugins"/>
        <xsl:apply-templates select="userinternetplugins"/>
        <xsl:apply-templates select="safariextensions"/>
        <xsl:apply-templates select="audioplugins"/>
        <xsl:apply-templates select="useraudioplugins"/>
        <xsl:apply-templates select="itunesplugins"/>
        <xsl:apply-templates select="useritunesplugins"/>
        <xsl:apply-templates select="preferencepanes"/>
        <xsl:apply-templates select="fonts"/>
        <xsl:apply-templates select="timemachine"/>
        <xsl:apply-templates select="cpu"/>
        <xsl:apply-templates select="memory"/>
        <xsl:apply-templates select="vm"/>
        <xsl:apply-templates select="diagnostics"/>
        <xsl:apply-templates select="etrecheckdeletedfiles"/>
            
      </body>

    </html>

  </xsl:template>

  <!-- EtreCheck stats. -->
  <xsl:template match="stats">
  
    <dl class="header">
      <dt>EtreCheck version:</dt>
      <dd>
        <xsl:value-of 
          select="/etrecheck/@version"/>
        <xsl:text> (</xsl:text>
        <xsl:value-of select="/etrecheck/@build"/>
        <xsl:text>)</xsl:text>
      </dd>
      <dt>Report generated:</dt>
      <dd><xsl:value-of select="date"/></dd>
      <dt>Download EtreCheck from</dt>
      <dd>https://etrecheck.com</dd>
      <dt>Runtime:</dt>
      <dd><xsl:value-of select="runtime"/></dd>
      <dt>Performance:</dt>
      <dd><xsl:value-of select="performance"/></dd>
    </dl>
    
    <!-- TODO: This needs to go when the links do. -->
    <ul class="instructions">
      <li>Click the [Support] links for help with non-Apple products.</li>
      <li>Click the [Details] links for more information about that line.</li>
    </ul>

  </xsl:template>

  <!-- User-specified problem. -->
  <xsl:template match="problem">
  
    <dl class="problem">
      <dt>Problem:</dt>
      <dd><xsl:value-of select="problem/type"/></dd>
      
      <!-- Description is optional. -->
      <xsl:if test="problem/description">
        <dt>Description:</dt>
        <dd><xsl:value-of select="problem/description"/></dd>
      </xsl:if>
    </dl>
      
  </xsl:template>

  <!-- Hardware information. -->
  <!-- TODO: Split this up. -->
  <xsl:template match="hardware">
  
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select ="local-name()"/>
      </xsl:attribute>      
      <h1>Hardware Information:</h1>
      <p><xsl:value-of select="marketingname"/></p>
      <dl>
        <dt>Class - model:</dt>
        <dd><xsl:value-of select="model"/></dd>
      </dl>
      <p><xsl:value-of select="cpucount"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="cpuspeed"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="cputype"/>
        <xsl:text> </xsl:text>(part #) CPU:<xsl:text> </xsl:text>
        <xsl:value-of select="corecount"/>-core</p>
      <p><xsl:value-of select="total"/> RAM</p>
      <ul>
        <!-- TODO: Handle the edge case of VMWare. -->
        <xsl:for-each select="memorybanks/memorybank">
          <li>
            <dl>
              <dt><xsl:value-of select="name"/></dt>
              <dd>
                <xsl:value-of select="size"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="type"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="speed"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="status"/>
              </dd>
            </dl>
          </li>
        </xsl:for-each>
      </ul>
      <dl class="hardware">
        <dt>Handoff:</dt>
        <dd><xsl:value-of select="supportshandoff"/></dd>
        <dt>Instant Hotspot:</dt>
        <dd><xsl:value-of select="supportsinstanthotspot"/></dd>
        <dt>Low energy:</dt>
        <dd><xsl:value-of select="supportslowenergy"/></dd>
        <dt>Wireless:</dt>
        <dd><xsl:value-of select="wirelessinterfaces/wirelessinterface/name"/></dd>
        <dd><xsl:value-of select="wirelessinterfaces/wirelessinterface/modes"/></dd>
        <dt>Battery:</dt>
        <dd>Health = <xsl:value-of select="batteryinformation/battery/health"/> - Cycle count = <xsl:value-of select="batteryinformation/battery/cyclecount"/></dd>
      </dl>
    </div>
      
  </xsl:template>
 
  <!-- Video information. -->
  <xsl:template match="video">
  
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select ="local-name()"/>
      </xsl:attribute>      
      <h1>Video Information:</h1>
      <ul>
        <xsl:for-each select="videocard">
          <li>
            <p><xsl:value-of select="name"/></p>
        
            <!-- Report displays, if any. -->
            <xsl:if test="count(display) &gt; 0">
              <ul>
                <xsl:for-each select="display">
                  <li>
                    <xsl:value-of select="name"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="resolution"/>
                  </li>
                </xsl:for-each>
              </ul>
            </xsl:if>
          </li>
        </xsl:for-each>
      </ul> 
    </div>
      
  </xsl:template>

  <!-- System software. -->
  <xsl:template match="systemsoftware">
  
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select ="local-name()"/>
      </xsl:attribute>      
      <h1>System Software:</h1>
      <p>
        <xsl:value-of select="version"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="concat('(', build,')')"/>
        <xsl:text> - Time since boot: </xsl:text>
      
        <!-- TODO: This looks like a localization problem. -->
        <xsl:value-of select="humanuptime"/>
      </p>
    </div>

  </xsl:template>

  <!-- Disk information. -->
  <xsl:template match="disk">
  
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select ="local-name()"/>
      </xsl:attribute>      
      <h1>Disk Information:</h1>
      <ul>
        <xsl:for-each select="controller">
          <xsl:for-each select="disk">
            <li>
              <p>
                <xsl:value-of select="name"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="device"/>
                <xsl:text> (</xsl:text>
                <xsl:value-of select="size"/>
                <xsl:text>)</xsl:text>
                <xsl:value-of select="concat('(', type, ' - TRIM: ', TRIM,')')"/>
                <xsl:if test="SMART != 'Verified'">
                  <xsl:value-of select="concat('S.M.A.R.T. Status: ', SMART)"/>
                </xsl:if>
              </p>
          
              <!-- Report volumes if there are any. -->
              <!-- TODO: Split this up. -->
              <xsl:if test="count(volumes/volume) &gt; 0">
                <ul>
                  <xsl:for-each select="volumes/volume">
                    <li>
                      <xsl:value-of select="name"/>
                      <xsl:text> </xsl:text>
                      <xsl:value-of select="concat('(', device, ')')"/>
                      <xsl:text> </xsl:text>
                      <xsl:choose>
                        <xsl:when test="mount_point">
                          <xsl:value-of select="mount_point"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:text> &lt;not mounted&gt; </xsl:text>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:text> </xsl:text>
                      <xsl:if test="type">
                        <xsl:value-of select="concat('[', type, ']')"/>
                      </xsl:if>
                      <xsl:text>: </xsl:text>
                      <xsl:call-template name="bytes">
                        <xsl:with-param name="value" select="size"/>
                      </xsl:call-template>
                      <xsl:if test="free_space">
                        <xsl:text> (</xsl:text>
                        <xsl:call-template name="bytes">
                          <xsl:with-param name="value" select="free_space"/>
                        </xsl:call-template>
                        <xsl:text> free)</xsl:text>
                      </xsl:if>
                      <xsl:if test="@encrypted = 'yes'">
                        <br/>
                        <xsl:text>Encrypted </xsl:text>
                        <xsl:value-of select="@encryption_type"/>
                        <xsl:choose>
                          <xsl:when test="@encryption_locked = 'no'">
                            <xsl:text> Unlocked</xsl:text>
                          </xsl:when>
                          <xsl:when test="@encryption_locked = 'yes'">
                            <xsl:text> Locked</xsl:text>
                          </xsl:when>
                        </xsl:choose>
                      </xsl:if>
                      <xsl:if test="core_storage">
                        <br/>
                        <xsl:text>Core Storage: </xsl:text>
                        <xsl:value-of select="core_storage/name"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="core_storage/size"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="core_storage/status"/>
                      </xsl:if>
                    </li>
                  </xsl:for-each>
                </ul>
              </xsl:if>
            </li>
          </xsl:for-each>
        </xsl:for-each>
      </ul>   
    </div>
    
  </xsl:template>

  <!-- USB information. -->
  <xsl:template match="usb">
  
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select ="local-name()"/>
      </xsl:attribute>      
      <h1>USB Information:</h1>
      <ul>
        <xsl:apply-templates mode="device"/>
      </ul>
    </div>
  
  </xsl:template>
  
  <!-- Firewire information. -->
  <xsl:template match="firewire">
  
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select ="local-name()"/>
      </xsl:attribute>      
      <h1>Firewire Information:</h1>
      <ul>
        <xsl:apply-templates mode="device"/>
      </ul>
    </div>
  
  </xsl:template>
  
  <!-- Thunderbolt information. -->
  <xsl:template match="thunderbolt">
  
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select ="local-name()"/>
      </xsl:attribute>      
      <h1>Thunderbolt Information:</h1>
      <ul>
        <xsl:apply-templates mode="device"/>
      </ul>
    </div>
  
  </xsl:template>
  
  <!-- TODO: This is wrong. Specify the devices to be matched. Don't use mode. -->
  <xsl:template match="*" mode="device">
  
    <li>
      <p><xsl:value-of select="name"/></p>
      <xsl:if test="manufacturer">
        <p><xsl:value-of select="manufacturer"/></p>
      </xsl:if>
      <xsl:if test="device">
        <ul>
          <xsl:apply-templates select="device" mode="device"/>
        </ul>
      </xsl:if>
    </li>
    
  </xsl:template>

  <!-- Configuration files. -->
  <xsl:template match="configurationfiles">
  
    <xsl:if test="filesizemismatch or unexpectedfile or SIP/value != 'enabled' or hostsfile/status != 'valid'">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>Configuration Files:</h1>
        <dl>
          <xsl:for-each select="filesizemismatch">
            <dt><xsl:value-of select="name"/></dt>
            <dd><xsl:value-of select="concat(', File size ', size, ' but expected ', expectedsize)"/></dd>
          </xsl:for-each>
          <xsl:for-each select="unexpectedfile">
            <dt><xsl:value-of select="name"/></dt>
            <dd><xsl:text> - File exists but not expected</xsl:text></dd>
          </xsl:for-each>
          <xsl:if test="SIP/value != 'enabled'">
            <dt>SIP:</dt>
            <dd><xsl:value-of select="SIP/value"/></dd>
          </xsl:if>
          <xsl:if test="hostsfile/status != 'valid'">
            <dt>/etc/hosts file:</dt>
            <dd><xsl:value-of select="hostsfile/status"/></dd>
          </xsl:if>
        </dl>
      </div>
    </xsl:if>
        
  </xsl:template>

  <!-- Gatekeeper information. -->
  <xsl:template match="gatekeeper">
  
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select ="local-name()"/>
      </xsl:attribute>      
      <h1>Gatekeeper:</h1>
      <p><xsl:value-of select="."/></p>
    </div>
      
  </xsl:template>

  <!-- Adware information. -->
  <xsl:template match="adware">
  
    <xsl:if test="adwarepath">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>Adware:</h1>
        <ul>
          <xsl:for-each select="adwarepath">
            <li><xsl:value-of select="."/></li>
          </xsl:for-each>
        </ul>
      </div>
    </xsl:if>
        
  </xsl:template>
  
  <!-- Unknown files. -->
  <xsl:template match="unknownfiles">
  
    <xsl:if test="unknownfile">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>Unknown Files:</h1>
        <dl>
          <xsl:for-each select="unknownfile">
            <dt><xsl:value-of select="path"/></dt>
            <dd><xsl:value-of select="command"/></dd>
          </xsl:for-each>
        </dl>
      </div>
    </xsl:if>
        
  </xsl:template>

  <!-- Kernel extensions. -->
  <xsl:template match="kernelextensions">
  
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select ="local-name()"/>
      </xsl:attribute>      
      <h1>Kernel Extensions:</h1>
      <dl>
        <xsl:for-each select="bundle">
          <xsl:call-template name="printExtensionBundle"/>
        </xsl:for-each>
      </dl>
    </div>
        
  </xsl:template>

  <!-- Print an extension bundle. -->
  <!-- TODO: Use a match instead of a name. -->
  <xsl:template name="printExtensionBundle">
  
    <xsl:if test="count(extensions/extension[ignore = 'true']) != count(extensions/extension)">
      <dt><xsl:value-of select="path"/></dt>
      <xsl:for-each select="extensions/extension">
        <dd>
          <xsl:value-of select="concat('[', status, '] ', label, ' (', version, ' - ', date, ')')"/>
        </dd>
      </xsl:for-each>
    </xsl:if>
    
  </xsl:template>

  <!-- Print startup items. -->
  <xsl:template match="startupitems">
  
    <xsl:if test="count(startupitem) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>Startup Items:</h1>
        <dl>
          <xsl:for-each select="startupitem">
            <dt><xsl:value-of select="name"/></dt>
            <dd><xsl:value-of select="path"/></dd>
            <dd><xsl:value-of select="version"/></dd>
          </xsl:for-each>
        </dl>
      </div>
    </xsl:if>
        
  </xsl:template>

  <!-- TODO: These can all be done more intelligently. -->
  
  <!-- Print system launch agents. -->
  <xsl:template match="systemlaunchagents">
  
    <xsl:if test="count(tasks[@analysis != 'apple']) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>System Launch Agents:</h1>
        <xsl:apply-templates select="tasks"/>
      </div>
    </xsl:if>
        
  </xsl:template>

  <!-- Print system launch daemons. -->
  <xsl:template match="systemlaunchdaemons">
  
    <xsl:if test="count(tasks[@analysis != 'apple']) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>System Launch Daemons:</h1>
        <xsl:apply-templates select="tasks"/>
      </div>
    </xsl:if>
        
  </xsl:template>

  <!-- Print launch agents. -->
  <xsl:template match="launchagents">
  
    <xsl:if test="count(tasks) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>Launch Agents:</h1>
        <xsl:apply-templates select="tasks"/>
      </div>
    </xsl:if>
        
  </xsl:template>

  <!-- Print launch daemons. -->
  <xsl:template match="launchdaemons">
  
    <xsl:if test="count(tasks) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>Launch Daemons:</h1>
        <xsl:apply-templates select="tasks"/>
      </div>
    </xsl:if>
        
  </xsl:template>

  <!-- Print user launch agents. -->
  <xsl:template match="userlaunchagents">
  
    <xsl:if test="count(tasks) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>User Launch Agents:</h1>
        <xsl:apply-templates select="tasks"/>
      </div>
    </xsl:if>
        
  </xsl:template>

  <!-- Print a launchd task. -->
  <xsl:template match="tasks">
  
    <ul>
      <xsl:for-each select="task">
        <li>
          <xsl:text>[</xsl:text>
          <xsl:value-of select="@status"/>
          <xsl:text>] </xsl:text>
          <xsl:value-of select="name"/>
          <xsl:text> (</xsl:text>
          <xsl:apply-templates select="date"/>
          <xsl:text>)</xsl:text>
        </li>
      </xsl:for-each>
    </ul>
        
  </xsl:template>

  <!-- Print login items. -->
  <xsl:template match="loginitems">
  
    <xsl:if test="count(loginitem) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>Login Items:</h1>
        <ul>
          <xsl:apply-templates select="loginitem"/>
        </ul>
      </div>
    </xsl:if>
        
  </xsl:template>

  <!-- Print a single login item. -->
  <xsl:template match="loginitem">
  
    <li>
      <xsl:value-of select="name"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="type"/>
      <xsl:text> (</xsl:text>
      <xsl:value-of select="path"/>
      <xsl:text>)</xsl:text>
    </li>
        
  </xsl:template>

  <!-- Print internet plugins. -->
  <xsl:template match="internetplugins">
  
    <xsl:if test="count(plugin) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>Internet Plug-ins:</h1>
        <ul>
          <xsl:apply-templates select="plugin"/>
        </ul>
      </div>
    </xsl:if>
        
  </xsl:template>

  <!-- Print user internet plugins. -->
  <xsl:template match="userinternetplugins">
  
    <xsl:if test="count(plugin) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>User Internet Plug-ins:</h1>
        <ul>
          <xsl:apply-templates select="plugin"/>
        </ul>
      </div>
    </xsl:if>
        
  </xsl:template>

  <!-- Print audio plugins. -->
  <xsl:template match="audioplugins">
  
    <xsl:if test="count(plugin) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>Audio Plug-ins:</h1>
        <ul>
          <xsl:apply-templates select="plugin"/>
        </ul>
      </div>
    </xsl:if>
        
  </xsl:template>

  <!-- Print user audio plugins. -->
  <xsl:template match="useraudioplugins">
  
    <xsl:if test="count(plugin) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>User Audio Plug-ins:</h1>
        <ul>
          <xsl:apply-templates select="plugin"/>
        </ul>
      </div>
    </xsl:if>
        
  </xsl:template>

  <!-- Print iTunes plugins. -->
  <xsl:template match="itunesplugins">
  
    <xsl:if test="count(plugin) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>iTunes Plug-ins:</h1>
        <ul>
          <xsl:apply-templates select="plugin"/>
        </ul>
      </div>
    </xsl:if>
        
  </xsl:template>

  <!-- Print user iTunes plugins. -->
  <xsl:template match="useritunesplugins">
  
    <xsl:if test="count(plugin) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>User iTunes Plug-ins:</h1>
        <ul>
          <xsl:apply-templates select="plugin"/>
        </ul>
      </div>
    </xsl:if>
        
  </xsl:template>

  <!-- Print a single plugin. -->
  <xsl:template match="plugin">
  
    <li>
      <xsl:value-of select="name"/>
      <xsl:text>: </xsl:text>
      <xsl:value-of select="version"/>
      <xsl:text> (</xsl:text>
      <xsl:apply-templates select="date"/>
      <xsl:text>)</xsl:text>
    </li>
        
  </xsl:template>

  <!-- Print Safari extensions. -->
  <xsl:template match="safariextensions">
  
    <xsl:if test="count(extension) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>Safari Extensions:</h1>
        <ul>
          <xsl:apply-templates select="extension"/>
        </ul>
      </div>
    </xsl:if>
        
  </xsl:template>
  
  <!-- Print a single Safari extension. -->
  <xsl:template match="extension">
  
    <li>
      <xsl:value-of select="name"/>
      <xsl:text> - </xsl:text>
      <xsl:value-of select="author"/>
      <xsl:text> - </xsl:text>
      <xsl:value-of select="url"/>
      <xsl:text> (</xsl:text>
      <xsl:apply-templates select="date"/>
      <xsl:text>)</xsl:text>
    </li>
        
  </xsl:template>

  <!-- Print Preference panes. -->
  <xsl:template match="preferencepanes">
  
    <xsl:if test="count(preferencepane) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>Preference Panes:</h1>
        <ul>
          <xsl:apply-templates select="preferencepane"/>
        </ul>
      </div>
    </xsl:if>
        
  </xsl:template>
  
  <!-- Print a single Preference pane. -->
  <xsl:template match="preferencepane">
  
    <li>
      <xsl:value-of select="name"/>
      <xsl:text> - </xsl:text>
      <xsl:value-of select="bundleid"/>
      <xsl:text> - </xsl:text>
      <xsl:apply-templates select="date"/>
      <xsl:text>)</xsl:text>
    </li>
        
  </xsl:template>

  <!-- Print Fonts. -->
  <xsl:template match="fonts">
  
    <xsl:if test="count(fonts) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>Fonts:</h1>
        <ul>
          <xsl:apply-templates select="font"/>
        </ul>
      </div>
    </xsl:if>
        
  </xsl:template>
  
  <!-- Print a single font. -->
  <xsl:template match="font">
  
    <li>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="@status"/>
      <xsl:text>] </xsl:text>
      <xsl:value-of select="name"/>
      <xsl:text> - </xsl:text>
      <xsl:apply-templates select="date"/>
      <xsl:text>)</xsl:text>
    </li>
        
  </xsl:template>

  <!-- Print Time Machine information. -->
  <xsl:template match="timemachine">
  
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select ="local-name()"/>
      </xsl:attribute>      
      <h1>Time Machine:</h1>
      <dl>
        <dt>Skip System Files:</dt>
        <dd><xsl:value-of select="skipsystemfiles"/></dd>
        <dt>Mobile backups:</dt>
        <dd><xsl:value-of select="mobilebackups"/></dd>
        <dt>Auto backup:</dt>
        <dd><xsl:value-of select="autobackup"/></dd>
        <dt>Volumes being backed up:</dt>
        <dd>
          <ul>
            <xsl:apply-templates select="backedupvolumes/volume"/>
          </ul>
        </dd>
        <dt>Destinations:</dt>
        <dd>
          <ul>
            <xsl:apply-templates select="destinations/destination"/>
          </ul>
        </dd>
      </dl>
    </div>
      
  </xsl:template>

  <!-- Print a Time Machine volume. -->
  <xsl:template match="volume">
  
    <dl>
      <dt></dt>
      <dd><xsl:value-of select="name"/></dd>
      <dt>Disk size:</dt>
      <dd>
        <xsl:call-template name="bytes">
          <xsl:with-param name="value" select="size"/>
        </xsl:call-template>
      </dd>
      <dt>Space required:</dt>
      <dd>
        <xsl:call-template name="bytes">
          <xsl:with-param name="value" select="sizerequired"/>
        </xsl:call-template>
      </dd>
    </dl>
      
  </xsl:template>

  <!-- Print a Time Machine destination. -->
  <xsl:template match="destination">
  
    <dl>
      <dt></dt>
      <dd><xsl:value-of select="name"/></dd>
      <dd><xsl:value-of select="concat('[', type, ']')"/></dd>
      <dt>Total size:</dt>
      <dd>
        <xsl:call-template name="bytes">
          <xsl:with-param name="value" select="size"/>
        </xsl:call-template>
      </dd>
      <dt>Total number of backups:</dt>
      <dd><xsl:value-of select="backupcount"/></dd>
      <dt>Oldest backup:</dt>
      <dd><xsl:value-of select="oldestbackupdate"/></dd>
      <dt>Last backup:</dt>
      <dd><xsl:value-of select="lastbackupdate"/></dd>
      <dt>Size of backup disk:</dt>
      <!-- TODO: Add backup analysis. -->
      <dd></dd>
    </dl>
      
  </xsl:template>

  <!-- Print a CPU usage information. -->
  <xsl:template match="cpu">
  
    <xsl:if test="count(process) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>Top Processes by CPU:</h1>
        <table>
          <xsl:for-each select="process">
            <tr>
              <td>
                <xsl:call-template name="percentage">
                  <xsl:with-param name="value">
                    <xsl:value-of select="cpu"/>
                  </xsl:with-param>
                </xsl:call-template>
              </td>
              <td>
                <xsl:value-of select="name"/>
                <xsl:if test="count &gt; 1">
                  <xsl:value-of select="concat('(', count, ')')"/>
                </xsl:if>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </div>
    </xsl:if>
      
  </xsl:template>

  <!-- Print a memory usage information. -->
  <xsl:template match="memory">
  
    <xsl:if test="count(process) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>Top Processes by Memory:</h1>
        <table>
          <xsl:for-each select="process">
            <tr>
              <td>
                <xsl:call-template name="bytes">
                  <xsl:with-param name="value" select="memory"/>
                </xsl:call-template>
              </td>
              <td>
                <xsl:value-of select="name"/>
                <xsl:if test="count &gt; 1">
                  <xsl:value-of select="concat('(', count, ')')"/>
                </xsl:if>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </div>
    </xsl:if>
      
  </xsl:template>

  <!-- Print a virtual memory usage information. -->
  <xsl:template match="vm">
  
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select ="local-name()"/>
      </xsl:attribute>      
      <h1>Virtual Memory Information:</h1>
      <table>
        <tr>
          <td>
            <xsl:call-template name="bytes">
              <xsl:with-param name="value" select="availableram"/>
            </xsl:call-template>
          </td>
          <td>Available RAM</td>
        </tr>
        <tr>
          <td>
            <xsl:call-template name="bytes">
              <xsl:with-param name="value" select="freeram"/>
            </xsl:call-template>
          </td>
          <td>Free RAM</td>
        </tr>
        <tr>
          <td>
            <xsl:call-template name="bytes">
              <xsl:with-param name="value" select="usedram"/>
            </xsl:call-template>
          </td>
          <td>Used RAM</td>
        </tr>
        <tr>
          <td>
            <xsl:call-template name="bytes">
              <xsl:with-param name="value" select="filecache"/>
            </xsl:call-template>
          </td>
          <td>Cached files</td>
        </tr>
        <tr>
          <td>
            <xsl:call-template name="bytes">
              <xsl:with-param name="value" select="swapused"/>
            </xsl:call-template>
          </td>
          <td>Swap Used:</td>
        </tr>
      </table>
    </div>
      
  </xsl:template>

  <!-- Print diagnostics information. -->
  <xsl:template match="diagnostics">
  
    <xsl:if test="count(diagnostic) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>Diagnostics Information:</h1>
      </div>
    </xsl:if>
      
  </xsl:template>

  <!-- Print a EtreCheck deleted files. -->
  <xsl:template match="etrecheckdeletedfiles">
  
    <xsl:if test="count(deletedfile) &gt; 0">
      <div>
        <xsl:attribute name="class">
          <xsl:value-of select ="local-name()"/>
        </xsl:attribute>      
        <h1>EtreCheck Deleted Files:</h1>
      </div>
    </xsl:if>
      
  </xsl:template>

  <xsl:template name="percentage">
    <xsl:param name="value"/>
    
    <xsl:value-of select="format-number($value div 100.0, '#.#%')"/>
  </xsl:template>

  <xsl:template name="bytes">
    <xsl:param name="value"/>
    <xsl:param name="units">1</xsl:param>
    
    <xsl:choose>
      <xsl:when test="$value &gt; 1024">
        <xsl:call-template name="bytes">
          <xsl:with-param name="value" select="$value div 1024"/>
          <xsl:with-param name="units" select="$units + 1"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="format-number($value, '#.##')"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="$byte_units[position() = $units]"/>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>

  <xsl:template match="date|*[@date]">
    <xsl:value-of select="substring-before(., ' ')"/>
  </xsl:template>
  
  <xsl:template match="*">
  
    <div class="section">
      <h1><xsl:value-of select="name(.)"/></h1>
    </div>
    
  </xsl:template>

</xsl:stylesheet>