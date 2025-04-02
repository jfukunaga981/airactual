var wms_layers = [];


        var lyr_GoogleSatellite_0 = new ol.layer.Tile({
            'title': 'Google Satellite',
            //'type': 'base',
            'opacity': 1.000000,
            
            
            source: new ol.source.XYZ({
    attributions: ' ',
                url: 'http://mt0.google.com/vt/lyrs=s&hl=en&x={x}&y={y}&z={z}'
            })
        });
var lyr_ClippedDSM_1 = new ol.layer.Image({
                            opacity: 1,
                            title: "Clipped DSM",
                            
                            
                            source: new ol.source.ImageStatic({
                               url: "./layers/ClippedDSM_1.png",
    attributions: ' ',
                                projection: 'EPSG:3857',
                                alwaysInRange: true,
                                imageExtent: [-13614649.103363, 4560018.351812, -13614251.922144, 4560539.546186]
                            })
                        });
var lyr_ClippedOrtho_2 = new ol.layer.Image({
                            opacity: 1,
                            title: "Clipped Ortho",
                            
                            
                            source: new ol.source.ImageStatic({
                               url: "./layers/ClippedOrtho_2.png",
    attributions: ' ',
                                projection: 'EPSG:3857',
                                alwaysInRange: true,
                                imageExtent: [-13614649.084951, 4560018.377185, -13614251.916294, 4560539.566891]
                            })
                        });

lyr_GoogleSatellite_0.setVisible(true);lyr_ClippedDSM_1.setVisible(false);lyr_ClippedOrtho_2.setVisible(true);
var layersList = [lyr_GoogleSatellite_0,lyr_ClippedDSM_1,lyr_ClippedOrtho_2];
