<cfoutput>
#linkTo(route="newrecipe", class="submitrecipe", title="Start Cooking", text="Start Cooking")#
<!---
<cfif isDefined("$latesttags")>
	#includePartial(title="Last 5 Tags", partial="/cooking/tags", $tags=$latesttags)#
</cfif>
--->

<h2>Twitter Feed</h2>

<script>
new TWTR.Widget({
  version: 2,
  type: 'profile',
  rpp: 4,
  interval: 6000,
  width: 'auto',
  height: 250,
  theme: {
    shell: {
      background: '##ffffff',
      color: '##333333'
    },
    tweets: {
      background: '##ffffff',
      color: '##666666',
      links: '##333333'
    }
  },
  features: {
    scrollbar: true,
    loop: false,
    live: true,
    hashtags: true,
    timestamp: true,
    avatars: true,
    behavior: 'all'
  }
}).render().setUser('cookingwheels').start();
</script>
</cfoutput>