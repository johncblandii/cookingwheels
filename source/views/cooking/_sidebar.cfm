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
  width: 250,
  height: 300,
  theme: {
    shell: {
      background: '##efefef',
      color: '##333333'
    },
    tweets: {
      background: '##ffffff',
      color: '##666666',
      links: '##e60000'
    }
  },
  features: {
    scrollbar: false,
    loop: false,
    live: false,
    hashtags: true,
    timestamp: true,
    avatars: true,
    behavior: 'all'
  }
}).render().setUser('cookingwheels').start();
</script>
</cfoutput>