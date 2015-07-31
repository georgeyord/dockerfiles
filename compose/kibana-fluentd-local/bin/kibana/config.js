/** @scratch /configuration/config.js/1
 *
 * == Configuration
 * config.js is where you will find the core Kibana configuration. This file contains parameter that
 * must be set before kibana is run for the first time.
 */
define(['settings'],
function (Settings) {


  /** @scratch /configuration/config.js/2
   *
   * === Parameters
   */
  return new Settings({

    elasticsearch: "http://"+window.location.hostname+":5680",
    default_route     : '/dashboard/file/default.json',
    kibana_index: "kibana-int",
    panel_names: [
      'histogram',
      'map',
      'goal',
      'table',
      'filtering',
      'timepicker',
      'text',
      'hits',
      'column',
      'trends',
      'bettermap',
      'query',
      'terms',
      'stats',
      'sparklines'
    ]
  });
});