import 'package:flutter/material.dart';
import '../components/custom_navbar.dart';

class CareersPage extends StatefulWidget {
  const CareersPage({super.key});

  @override
  State<CareersPage> createState() => _CareersPageState();
}

class _CareersPageState extends State<CareersPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _experienceController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _additionalController = TextEditingController();

  List<String> selectedSubjects = [];
  List<String> selectedGrades = [];
  List<String> selectedBoards = [];
  String offlineAvailability = '';

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _experienceController.dispose();
    _qualificationController.dispose();
    _additionalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavbar(
        title: 'Careers',
        showBackButton: true,
      ),
      drawer: const CustomDrawer(),
      backgroundColor: const Color(0xFFFFFDF7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildApplicationForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F1729), // Much darker blue
            Color(0xFF1E3A8A), // Darker blue
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 20.0 : 32.0),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Join Our Team',
                    style: TextStyle(
                      fontSize: isMobile ? 32 : 40,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'At Incendia, we believe great teachers don\'t just teach — they ignite, mentor, and transform.',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildFeatureCards(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCards() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    if (isMobile) {
      return Column(
        children: [
          _buildFeatureCard(
            '🎯',
            'Purpose-Driven',
            'Make a real impact on students\' lives',
          ),
          const SizedBox(height: 16),
          _buildFeatureCard(
            '💡',
            'Innovation',
            'Use cutting-edge teaching methods',
          ),
          const SizedBox(height: 16),
          _buildFeatureCard(
            '📚',
            'Growth',
            'Continuous learning opportunities',
          ),
        ],
      );
    }
    
    return Row(
      children: [
        Expanded(
          child: _buildFeatureCard(
            '🎯',
            'Purpose-Driven',
            'Make a real impact on students\' lives',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildFeatureCard(
            '💡',
            'Innovation',
            'Use cutting-edge teaching methods',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildFeatureCard(
            '📚',
            'Growth',
            'Continuous learning opportunities',
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(String emoji, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationForm() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : 32),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Application Form',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFF0F1729), // Updated to darker blue
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'We\'re excited to learn more about you!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),
              
              _buildPersonalInfo(),
              const SizedBox(height: 40),
              
              _buildSubjectSelection(),
              const SizedBox(height: 40),
              
              _buildGradeSelection(),
              const SizedBox(height: 40),
              
              _buildBoardSelection(),
              const SizedBox(height: 40),
              
              _buildExperienceQualification(),
              const SizedBox(height: 40),
              
              _buildAvailability(),
              const SizedBox(height: 40),
              
              _buildAdditionalInfo(),
              const SizedBox(height: 40),
              
              _buildSubmitButton(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Personal Information'),
        const SizedBox(height: 20),
        _buildTextField(
          controller: _nameController,
          label: 'Full Name',
          hint: 'Enter your full name',
          icon: Icons.person,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _mobileController,
          label: 'Mobile Number',
          hint: 'Enter your mobile number',
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _emailController,
          label: 'Email ID',
          hint: 'Enter your email address',
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _buildSubjectSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Subjects You Can Teach'),
        const SizedBox(height: 20),
        _buildCheckboxGroup(
          options: ['Maths', 'Physics', 'Chemistry', 'Biology', 'Hindi', 'Kannada', 'Others'],
          selectedOptions: selectedSubjects,
          onChanged: (value) {
            setState(() {
              if (selectedSubjects.contains(value)) {
                selectedSubjects.remove(value);
              } else {
                selectedSubjects.add(value);
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildGradeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Grades You\'re Comfortable With'),
        const SizedBox(height: 20),
        _buildCheckboxGroup(
          options: ['Grade 9', 'Grade 10', 'Grade 11', 'Grade 12'],
          selectedOptions: selectedGrades,
          onChanged: (value) {
            setState(() {
              if (selectedGrades.contains(value)) {
                selectedGrades.remove(value);
              } else {
                selectedGrades.add(value);
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildBoardSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Boards You\'ve Taught or Are Comfortable With'),
        const SizedBox(height: 20),
        _buildCheckboxGroup(
          options: ['CBSE', 'ICSE', 'State Board', 'Others'],
          selectedOptions: selectedBoards,
          onChanged: (value) {
            setState(() {
              if (selectedBoards.contains(value)) {
                selectedBoards.remove(value);
              } else {
                selectedBoards.add(value);
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildExperienceQualification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Professional Background'),
        const SizedBox(height: 20),
        _buildTextField(
          controller: _experienceController,
          label: 'Teaching Experience',
          hint: 'e.g., 2 years, Fresher',
          icon: Icons.work,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _qualificationController,
          label: 'Qualification',
          hint: 'e.g., MSc Physics, B.Ed., etc.',
          icon: Icons.school,
        ),
      ],
    );
  }

  Widget _buildAvailability() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Availability'),
        const SizedBox(height: 20),
        Text(
          'Are You Comfortable Teaching Offline at Indiranagar (Mon–Fri, 6–9 PM)?',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF0F1729), // Updated to darker blue
          ),
        ),
        const SizedBox(height: 12),
        _buildRadioGroup(
          options: ['Yes', 'No', 'Maybe'],
          selectedValue: offlineAvailability,
          onChanged: (value) {
            setState(() {
              offlineAvailability = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildAdditionalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Additional Information'),
        const SizedBox(height: 20),
        _buildTextField(
          controller: _additionalController,
          label: 'Anything You\'d Like to Share With Us',
          hint: 'Tell us more about yourself, your teaching philosophy, or any special skills...',
          icon: Icons.message,
          maxLines: 4,
          isRequired: false,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF0F1729), // Updated to darker blue
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool isRequired = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF0F1729), // Updated to darker blue
            ),
            children: isRequired
                ? [
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                }
              : null,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: const Color(0xFF0F1729)), // Updated to darker blue
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF0F1729), width: 2), // Updated to darker blue
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxGroup({
    required List<String> options,
    required List<String> selectedOptions,
    required Function(String) onChanged,
  }) {
    return FormField<List<String>>(
      validator: (value) {
        if (selectedOptions.isEmpty) {
          return 'Please select at least one option';
        }
        return null;
      },
      builder: (FormFieldState<List<String>> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: options.map((option) {
                final isSelected = selectedOptions.contains(option);
                return GestureDetector(
                  onTap: () => onChanged(option),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF0F1729) : Colors.white, // Updated to darker blue
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF0F1729) : Colors.grey.shade300, // Updated to darker blue
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSelected ? Icons.check_circle : Icons.circle_outlined,
                          color: isSelected ? Colors.white : Colors.grey.shade600,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          option,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey.shade700,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildRadioGroup({
    required List<String> options,
    required String selectedValue,
    required Function(String) onChanged,
  }) {
    return FormField<String>(
      validator: (value) {
        if (offlineAvailability.isEmpty) {
          return 'Please select an option';
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: options.map((option) {
                final isSelected = selectedValue == option;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onChanged(option),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF0F1729) : Colors.white, // Updated to darker blue
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF0F1729) : Colors.grey.shade300, // Updated to darker blue
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                            color: isSelected ? Colors.white : Colors.grey.shade600,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            option,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey.shade700,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F1729), Color(0xFF1E3A8A)], // Updated to darker blues
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F1729).withOpacity(0.3), // Updated to darker blue
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Submit Application',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: const Color(0xFF4CAF50),
                  size: 28,
                ),
                const SizedBox(width: 12),
                const Text('Application Submitted!'),
              ],
            ),
            content: const Text(
              'Thank you for your interest in joining Incendia! We\'ll review your application and get back to you soon.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _resetForm();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _resetForm() {
    _nameController.clear();
    _mobileController.clear();
    _emailController.clear();
    _experienceController.clear();
    _qualificationController.clear();
    _additionalController.clear();
    setState(() {
      selectedSubjects.clear();
      selectedGrades.clear();
      selectedBoards.clear();
      offlineAvailability = '';
    });
  }
}