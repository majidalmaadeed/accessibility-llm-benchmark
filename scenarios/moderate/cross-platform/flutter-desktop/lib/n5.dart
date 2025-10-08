import 'package:flutter/material.dart';
  @override
}
  @override
  void initState() {
    super.initState();
  }
    // Basic setup only
  }
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Main Content Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Color(0xFFDEE2E6)),
              ),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Text(
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Description
                    const Text(
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFDEE2E6)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFF8F9FA),
                              border: Border(
                                bottom: BorderSide(color: Color(0xFFDEE2E6)),
                              ),
                            ),
                            child: Row(
                                return Expanded(
                                  child: InkWell(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: isActive ? Colors.white : const Color(0xFFF8F9FA),
                                        border: isActive
                                            ? const Border(
                                                bottom: BorderSide(color: Color(0xFF007BFF), width: 3),
                                              )
                                            : null,
                                      ),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isActive ? const Color(0xFF007BFF) : const Color(0xFF333333),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(30),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: Color(0xFFDEE2E6)),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFE9ECEF),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF666666),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // How to Fix
                    const Text(
                      '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  }
      case 'general':
      case 'security':
      case 'privacy':
      case 'advanced':
      default:
        return const SizedBox.shrink();
    }
  }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'General Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            _buildCheckbox('Start application on system startup', false),
            const SizedBox(height: 20),
            _buildCheckbox('Enable desktop notifications', false),
            const SizedBox(height: 20),
            _buildCheckbox('Automatically check for updates', false),
            const SizedBox(height: 20),
            _buildDropdownField('Theme:', ['Light', 'Dark', 'Auto'], 'Light'),
          ],
        ),
      ],
    );
  }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Security Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            _buildCheckbox('Enable two-factor authentication', false),
            const SizedBox(height: 20),
            _buildCheckbox('Use biometric authentication', false),
            const SizedBox(height: 20),
            _buildCheckbox('Enable session timeout', false),
            const SizedBox(height: 20),
            _buildTextField('Session timeout (minutes):', '30'),
          ],
        ),
      ],
    );
  }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Privacy Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            _buildCheckbox('Allow usage analytics', false),
            const SizedBox(height: 20),
            _buildCheckbox('Send crash reports', false),
            const SizedBox(height: 20),
            _buildCheckbox('Allow location access', false),
            const SizedBox(height: 20),
            _buildTextField('Data retention (days):', '90'),
          ],
        ),
      ],
    );
  }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Advanced Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            _buildCheckbox('Enable debug mode', false),
            const SizedBox(height: 20),
            _buildCheckbox('Enable verbose logging', false),
            const SizedBox(height: 20),
            _buildCheckbox('Enable experimental features', false),
            const SizedBox(height: 20),
            _buildDropdownField('Log level:', ['Error', 'Warning', 'Info', 'Debug'], 'Info'),
          ],
        ),
      ],
    );
  }
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (bool? newValue) {
            // Handle checkbox change
          },
        ),
        const SizedBox(width: 10),
        Text(
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (String? newValue) {
            // Handle dropdown change
          },
        ),
      ],
    );
  }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 100,
          child: TextFormField(
            initialValue: value,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
            onChanged: (String newValue) {
              // Handle text change
            },
          ),
        ),
      ],
    );
  }
}
