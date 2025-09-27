#ifndef MAPWIDGET_H
#define MAPWIDGET_H

#include <QWidget>
#include <QPushButton>
#include <QLineEdit>
#include <QComboBox>
#include <QCheckBox>
#include <QSlider>
#include <QLabel>
#include <QGroupBox>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QGridLayout>
#include <QListWidget>
#include <QTableWidget>
#include <QProgressBar>

class MapWidget : public QWidget
{
    Q_OBJECT

public:
    explicit MapWidget(QWidget *parent = nullptr);

private slots:
    void searchLocation();
    void clearSearch();
    void toggleLayer();
    void zoomIn();
    void zoomOut();
    void resetView();
    void showDirections();
    void exportMap();
    void shareMap();
    void addMarker();
    void removeMarker();
    void editMarker();
    void showInfo();
    void hideInfo();
    void updateMap();
    void onSearchChanged();
    void onLayerChanged();
    void onZoomChanged();
    void onMarkerChanged();
    void onInfoChanged();

private:
    void setupUI();
    void setupMap();
    void setupControls();
    void setupLayers();
    void setupMarkers();
    void updateMap();
    void updateControls();
    void updateLayers();
    void updateMarkers();
    void searchLocation();
    void clearSearch();
    void toggleLayer();
    void zoomIn();
    void zoomOut();
    void resetView();
    void showDirections();
    void exportMap();
    void shareMap();
    void addMarker();
    void removeMarker();
    void editMarker();
    void showInfo();
    void hideInfo();
    void onSearchChanged();
    void onLayerChanged();
    void onZoomChanged();
    void onMarkerChanged();
    void onInfoChanged();
    
    // Map
    QWidget *m_mapWidget;
    QLabel *m_mapLabel;
    QProgressBar *m_loadingBar;
    
    // Controls
    QLineEdit *m_searchEdit;
    QPushButton *m_searchButton;
    QPushButton *m_clearButton;
    QPushButton *m_zoomInButton;
    QPushButton *m_zoomOutButton;
    QPushButton *m_resetButton;
    QPushButton *m_directionsButton;
    QPushButton *m_exportButton;
    QPushButton *m_shareButton;
    
    // Layers
    QGroupBox *m_layerGroup;
    QCheckBox *m_trafficCheck;
    QCheckBox *m_satelliteCheck;
    QCheckBox *m_terrainCheck;
    QCheckBox *m_streetCheck;
    QCheckBox *m_poiCheck;
    QCheckBox *m_transitCheck;
    
    // Markers
    QGroupBox *m_markerGroup;
    QListWidget *m_markerList;
    QPushButton *m_addMarkerButton;
    QPushButton *m_removeMarkerButton;
    QPushButton *m_editMarkerButton;
    
    // Info
    QGroupBox *m_infoGroup;
    QLabel *m_infoLabel;
    QPushButton *m_showInfoButton;
    QPushButton *m_hideInfoButton;
    
    // Data
    QList<QVariantMap> m_markers;
    QList<QVariantMap> m_layers;
    QString m_currentLocation;
    int m_currentZoom;
    bool m_isSearching;
    bool m_isLoading;
    bool m_isExporting;
    bool m_isSharing;
    bool m_isAddingMarker;
    bool m_isRemovingMarker;
    bool m_isEditingMarker;
    bool m_isShowingInfo;
    bool m_isHidingInfo;
};

#endif // MAPWIDGET_H
