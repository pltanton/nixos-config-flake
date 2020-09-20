broker_url:

{
  mqtt = {
    identifier = "rockrobo";
    topicPrefix = "valetudo";
    autoconfPrefix = "homeassistant";
    broker_url = "${broker_url}";
    caPath = "";
    mapDataTopic = "valetudo/rockrobo/map_data";
    minMillisecondsBetweenMapUpdates = 10000;
    publishMapImage = true;
    publishMapData = true;
  };
  mapSettings = {
    colors = {
      background = "#33a1f5";
      background2 = "#046cd4";
      floor = "#56affc";
      obstacle_strong = "#a1dbff";
      path = "white";
      forbidden_marker = "red";
      forbidden_zone = "rgba(255, 0, 0, 0.38)";
      cleaned_marker = "rgba(53, 125, 46, 1.0)";
      cleaned_zone = "rgba(107, 244, 66, 0.3)";
      cleaned_block = "rgba(107, 244, 36, 0.34)";
    };
    drawPath = true;
    drawCharger = true;
    drawRobot = true;
    drawCurrentlyCleanedZones = true;
    drawCurrentlyCleanedBlocks = false;
    drawForbiddenZones = true;
    drawVirtualWalls = true;
    scale = 4;
    gradientBackground = true;
    autoCrop = 20;
    #crop_x1= 30,
    #crop_y1= 70,
    #crop_x2= 440,
    #crop_y2= 440
  };
  webserver = {
    enabled = true;
    port = 3000;
  };
}
