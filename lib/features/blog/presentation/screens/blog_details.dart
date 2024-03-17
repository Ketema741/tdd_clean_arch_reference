import 'package:tdd_clean_architecture/core/constants/theme_constants.dart';
import 'package:tdd_clean_architecture/features/blog/presentation/screens/education.dart';
import 'package:tdd_clean_architecture/features/blog/presentation/screens/exprience.dart';
import 'package:tdd_clean_architecture/features/blog/presentation/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
// import 'package:hakimhub_mobile/features/hospitals/presentation/widgets/education.dart';
// import 'package:hakimhub_mobile/features/hospitals/presentation/widgets/exprience.dart';

class BlogDetailScreen extends StatelessWidget {
  final String doctorName;
  final List<String> doctorSpecialties;
  final String doctorPhone;
  final String doctorEmail;
  // final String doctorRating;
  final String doctorExperience;
  final List<Experience> experiences;
  final List<Education> educations;
  // Added this line

  const BlogDetailScreen({
    super.key,
    required this.doctorName,
    required this.doctorSpecialties,
    required this.doctorPhone,
    required this.doctorEmail,
    // required this.doctorRating,
    required this.doctorExperience,
    required this.experiences,
    required this.educations,
    // Added this line
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Doctor's name, rating, and photo
              Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctorName,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '$doctorExperience Years of Experience ', // Added this line
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // About me container
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About me:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'I am a doctor with 10 years of experience. I have worked in various hospitals and have treated many patients. I am passionate about my work and I always strive to provide the best care to my patients.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 10),
              const Divider(
                  color: Color.fromARGB(255, 92, 92, 92), thickness: 0.20),
              // Specialty container
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      ' My Specialties',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // SizedBox(height: 8),
                    Wrap(
                      spacing: 5.0,
                      runSpacing: 5.0,
                      children: doctorSpecialties.map((specialty) {
                        return Container(
                          decoration: BoxDecoration(
                            color: ThemeConstants.cardColor,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              specialty,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 16),
              // Experience container
              const Divider(
                  color: Color.fromARGB(255, 92, 92, 92), thickness: 0.20),

              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      top: 8,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Experience',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: experiences.length,
                    itemBuilder: (context, index) {
                      return _buildExperienceCard(experiences[index]);
                    },
                  ),
                  const Divider(
                      color: Color.fromARGB(255, 92, 92, 92), thickness: 0.20),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      top: 8,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Education',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: educations.length,
                    itemBuilder: (context, index) {
                      return _buildEducationCard(educations[index]);
                    },
                  ),
                ],
              ),

              const Divider(
                  color: Color.fromARGB(255, 92, 92, 92), thickness: 0.20),
              // Reviews container
            ])),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

Widget _buildExperienceCard(Experience experience) {
  return ListTile(
    title: Text(experience.title),
    subtitle: Text(experience.description),
    trailing: Text(experience.date), // Display date on the right side
  );
}

Widget _buildEducationCard(Education education) {
  return ListTile(
    title: Text(education.school),
    subtitle: Text(education.degree),
    trailing: Text(education.date),
  );
}
