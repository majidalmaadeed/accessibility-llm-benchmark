import React, { useState, useEffect } from 'react';
const ProgressIndicatorGaps = () => {
  const [uploadProgress, setUploadProgress] = useState(0);
  const [isUploading, setIsUploading] = useState(false);
  const [uploadStatus, setUploadStatus] = useState('idle'); // idle, uploading, completed, error
  const [selectedFiles, setSelectedFiles] = useState([]);
  const [uploadSpeed, setUploadSpeed] = useState(0);
  const [timeRemaining, setTimeRemaining] = useState(0);
  const simulateUpload = () => {
    setIsUploading(true);
    setUploadStatus('uploading');
    setUploadProgress(0);
    setUploadSpeed(0);
    setTimeRemaining(0);
    const interval = setInterval(() => {
      setUploadProgress(prev => {
        const newProgress = prev + Math.random() * 10;
        if (newProgress >= 100) {
          clearInterval(interval);
          setIsUploading(false);
          setUploadStatus('completed');
          setUploadSpeed(0);
          setTimeRemaining(0);
          return 100;
        }
        // Simulate varying upload speed
        const speed = Math.random() * 2 + 0.5; // 0.5-2.5 MB/s
        setUploadSpeed(speed);
        // Calculate time remaining
        const remaining = (100 - newProgress) / (speed * 10); // Rough calculation
        setTimeRemaining(Math.max(0, remaining));
        return newProgress;
      });
    }, 200);
  };
  const cancelUpload = () => {
    setIsUploading(false);
    setUploadStatus('idle');
    setUploadProgress(0);
    setUploadSpeed(0);
    setTimeRemaining(0);
  };
  const resetUpload = () => {
    setUploadStatus('idle');
    setUploadProgress(0);
    setSelectedFiles([]);
    setUploadSpeed(0);
    setTimeRemaining(0);
  };
  const handleFileSelect = (e) => {
    const files = Array.from(e.target.files);
    setSelectedFiles(files);
    setUploadStatus('idle');
    setUploadProgress(0);
  };
  const formatFileSize = (bytes) => {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
  };
  const formatTime = (seconds) => {
    if (seconds < 60) return `${Math.round(seconds)}s`;
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = Math.round(seconds % 60);
    return `${minutes}m ${remainingSeconds}s`;
  };
  const getStatusMessage = () => {
    switch (uploadStatus) {
      case 'uploading':
        return `Uploading... ${Math.round(uploadProgress)}% complete`;
      case 'completed':
        return 'Upload completed successfully!';
      case 'error':
        return 'Upload failed. Please try again.';
      default:
        return 'Ready to upload';
    }
  };
  return (
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <h1>File Upload</h1>
        <p>Upload files and track their progress using the interface below.</p>
        {/* File Selection */}
        <div style={{ marginBottom: '30px' }}>
          <h2 style={{ marginBottom: '20px', color: '#333' }}>Upload Files</h2>
          <div style={{ marginBottom: '20px' }}>
              Select files to upload:
            <input
              type="file"
              id="file-input"
              multiple
              onChange={handleFileSelect}
              style={{
                width: '100%',
                padding: '8px',
                border: '2px dashed #ddd',
                borderRadius: '4px',
                fontSize: '14px'
              }}
            />
          </div>
          {selectedFiles.length > 0 && (
            <div style={{ marginBottom: '20px' }}>
              <h3 style={{ marginBottom: '10px', color: '#333' }}>Selected Files:</h3>
              <ul style={{ listStyle: 'none', padding: 0 }}>
                {selectedFiles.map((file, index) => (
                  <li key={index} style={{ 
                    padding: '8px 12px', 
                    background: '#f8f9fa', 
                    border: '1px solid #ddd', 
                    borderRadius: '4px',
                    marginBottom: '8px',
                    display: 'flex',
                    justifyContent: 'space-between',
                    alignItems: 'center'
                  }}>
                    <span>{file.name}</span>
                    <span style={{ color: '#666', fontSize: '12px' }}>
                      {formatFileSize(file.size)}
                    </span>
                  </li>
                ))}
              </ul>
            </div>
          )}
        </div>
        {/* Upload Controls */}
        <div style={{ marginBottom: '30px' }}>
          <div style={{ display: 'flex', gap: '12px', marginBottom: '20px' }}>
            <button
              onClick={simulateUpload}
              disabled={isUploading || selectedFiles.length === 0}
              style={{
                background: isUploading ? '#6c757d' : '#007bff',
                color: 'white',
                border: 'none',
                padding: '10px 20px',
                borderRadius: '4px',
                cursor: isUploading ? 'not-allowed' : 'pointer',
                fontSize: '14px'
              }}
            >
              {isUploading ? 'Uploading...' : 'Start Upload'}
            </button>
            {isUploading && (
              <button
                onClick={cancelUpload}
                style={{
                  background: '#dc3545',
                  color: 'white',
                  border: 'none',
                  padding: '10px 20px',
                  borderRadius: '4px',
                  cursor: 'pointer',
                  fontSize: '14px'
                }}
              >
                Cancel Upload
              </button>
            )}
            {uploadStatus === 'completed' && (
              <button
                onClick={resetUpload}
                style={{
                  background: '#28a745',
                  color: 'white',
                  border: 'none',
                  padding: '10px 20px',
                  borderRadius: '4px',
                  cursor: 'pointer',
                  fontSize: '14px'
                }}
              >
                Upload More Files
              </button>
            )}
          </div>
        </div>
        {}
        {(isUploading || uploadStatus === 'completed') && (
          <div style={{ marginBottom: '30px' }}>
            <h3 style={{ marginBottom: '15px', color: '#333' }}>Upload Progress</h3>
            {}
            <div
              style={{
                marginBottom: '15px',
                padding: '12px',
                background: uploadStatus === 'completed' ? '#d4edda' : '#d1ecf1',
                border: `1px solid ${uploadStatus === 'completed' ? '#c3e6cb' : '#bee5eb'}`,
                borderRadius: '4px',
                color: uploadStatus === 'completed' ? '#155724' : '#0c5460',
                fontWeight: '500'
              }}
            >
              {getStatusMessage()}
            </div>
            {}
            <div style={{ marginBottom: '15px' }}>
              <div
                style={{
                  width: '100%',
                  height: '20px',
                  background: '#e9ecef',
                  borderRadius: '10px',
                  overflow: 'hidden',
                  position: 'relative'
                }}
              >
                <div
                  style={{
                    width: `${uploadProgress}%`,
                    height: '100%',
                    background: uploadStatus === 'completed' ? '#28a745' : '#007bff',
                    transition: 'width 0.3s ease',
                    borderRadius: '10px'
                  }}
                />
                <div
                  style={{
                    position: 'absolute',
                    top: '50%',
                    left: '50%',
                    transform: 'translate(-50%, -50%)',
                    color: '#333',
                    fontSize: '12px',
                    fontWeight: 'bold'
                  }}
                >
                  {Math.round(uploadProgress)}%
                </div>
              </div>
            </div>
            {/* Upload Details */}
            {isUploading && (
              <div style={{ 
                display: 'grid', 
                gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', 
                gap: '15px',
                fontSize: '14px',
                color: '#666'
              }}>
                <div>
                  <strong>Upload Speed:</strong> {uploadSpeed.toFixed(1)} MB/s
                </div>
                <div>
                  <strong>Time Remaining:</strong> {formatTime(timeRemaining)}
                </div>
                <div>
                  <strong>Files:</strong> {selectedFiles.length} file{selectedFiles.length !== 1 ? 's' : ''}
                </div>
                <div>
                  <strong>Total Size:</strong> {formatFileSize(selectedFiles.reduce((total, file) => total + file.size, 0))}
                </div>
              </div>
            )}
          </div>
        )}
        {/* Instructions */}
        <div style={{ 
          marginTop: '30px', 
          padding: '20px', 
          background: '#f8f9fa', 
          borderRadius: '4px',
          fontSize: '14px',
          color: '#666'
        }}>
          <h4 style={{ margin: '0 0 10px 0', color: '#333' }}>Instructions:</h4>
          <ul style={{ margin: '0', paddingLeft: '20px' }}>
            <li>Select one or more files using the file input above</li>
            <li>Click "Start Upload" to begin the upload process</li>
            <li>Monitor progress using the progress bar and status information</li>
            <li>Use "Cancel Upload" to stop the upload process</li>
            <li>Upload will complete automatically after reaching 100%</li>
          </ul>
        </div>
      </div>
      <div style={{ marginTop: '30px', padding: '20px', backgroundColor: '#e9ecef', borderRadius: '4px' }}>
      </div>
    </div>
  );
};
export default ProgressIndicatorGaps;