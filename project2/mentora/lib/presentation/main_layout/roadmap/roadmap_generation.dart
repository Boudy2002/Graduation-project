import 'package:flutter/material.dart';
import 'package:mentora_app/core/routes_manager.dart';
import 'package:mentora_app/core/widgets/custom_elevated_button.dart';
import 'package:mentora_app/data/DM/user_dm.dart';
import 'package:mentora_app/data/firebase/firebase_services.dart';
import 'package:mentora_app/presentation/main_layout/roadmap/models/milestone.dart';
import 'package:mentora_app/presentation/main_layout/roadmap/models/roadmap.dart';
import 'package:mentora_app/presentation/main_layout/roadmap/services/api_service.dart';
import 'package:mentora_app/core/colors_manager.dart';

// import 'package:roadmap_tester_app/models/roadmap.dart';
// import 'package:roadmap_tester_app/models/milestone.dart';
// import 'package:roadmap_tester_app/models/learning_resource.dart';
// import 'package:roadmap_tester_app/services/api_service.dart';
import 'dart:ui'; // Required for ImageFilter.blur

class RoadmapGeneratorScreen extends StatefulWidget {
  const RoadmapGeneratorScreen({super.key});

  @override
  State<RoadmapGeneratorScreen> createState() => _RoadmapGeneratorScreenState();
}

class _RoadmapGeneratorScreenState extends State<RoadmapGeneratorScreen> {
  Roadmap? _roadmap;
  bool _isLoading = false;
  String? _errorMessage;
  bool isProjectDone = false;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getRoadmap() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final roadmap = Roadmap.currentRoadmap;
      setState(() {
        _roadmap = roadmap;
        // Initialize completion status
        if (_roadmap != null) {
          int totalMilestones = _roadmap!.stages.fold(
              0,
                  (sum, stage) => sum + stage.milestones.length
          );
          milestoneCompletionStatus = List<bool>.filled(totalMilestones, false);
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to load roadmap: ${e.toString()}";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // New method to show milestone details
  void _showMilestoneDetails(Milestone milestone, int stageIndex,
      int milestoneIndex) {
    int globalIndex = 0;
    for (int i = 0; i < stageIndex; i++) {
      globalIndex += _roadmap!.stages[i].milestones.length;
    }
    globalIndex += milestoneIndex;

    int firstIncomplete = milestoneCompletionStatus.indexWhere((
        status) => !status);
    if (globalIndex != firstIncomplete) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.25,
          maxChildSize: 0.9,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Container(
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      milestone.name,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      milestone.description,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Estimated Duration: ${milestone.estimatedDuration}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Learning Goals:',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    ...milestone.learningGoals.map(
                          (goal) =>
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, bottom: 4.0),
                            child: Text(
                              '• $goal',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium,
                            ),
                          ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Skills Acquired:',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: milestone.skillsAcquired.map(
                            (skill) =>
                            Chip(
                              label: Text(skill),
                              backgroundColor: Colors.blue.shade50,
                            ),
                      ).toList(),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Learning Resources:',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    ...milestone.resources.map(
                          (resource) =>
                          Card(
                            margin: const EdgeInsets.only(bottom: 8.0),
                            child: ListTile(
                              title: Text(
                                resource.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(resource.type),
                              trailing: resource.link != null
                                  ? IconButton(
                                icon: const Icon(Icons.open_in_new),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Open URL: ${resource.link!}'),
                                    ),
                                  );
                                },
                              )
                                  : null,
                            ),
                          ),
                    ),
                    const SizedBox(height: 15),
                    if (milestone.miniProject != null &&
                        milestone.miniProject!.isNotEmpty)
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mini Project:',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                milestone.miniProject!,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium,
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: CustomElevatedButton(
                                  text: "Mark as Complete",
                                  onPress: () async {
                                    try {
                                      setState(() {
                                        milestoneCompletionStatus[globalIndex] = true;
                                      });
                                      
                                      // Update the current user's milestone completion status
                                      UserDM.currentUser!.milestoneCompletionStatus =
                                          milestoneCompletionStatus.map((value) => value.toString()).toList();
                                      
                                      print("Before Firebase update - Milestone $globalIndex set to true");
                                      print("Updated milestoneCompletionStatus: ${UserDM.currentUser!.milestoneCompletionStatus}");
                                      
                                      // Save to Firebase
                                      await FirebaseServices.updateUserData(UserDM.currentUser!);
                                      
                                      print("Successfully saved to Firebase!");
                                      
                                      Navigator.pop(context);
                                      setState(() {}); // Refresh the parent widget
                                    } catch (e) {
                                      print("Error saving milestone completion to Firebase: $e");
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("Error saving progress: $e"),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 15),
                            ],
                          );
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRoadmapItem(String title,
      String status, {
        Milestone? milestone,
        required int stageIndex,
        required int milestoneIndex,
      }) {
    IconData? icon;
    Color iconColor;

    switch (status) {
      case 'completed':
        icon = Icons.check_circle;
        iconColor = Colors.green;
        break;
      case 'current':
        icon = Icons.circle_outlined;
        iconColor = Colors.green;
        break;
      case 'locked':
      default:
        icon = Icons.lock;
        iconColor = const Color(0xFFDADADA);
        break;
    }

    const double circleRadius = 40;

    return GestureDetector(
      onTap: () {
        if (milestone != null && status == 'current') {
          _showMilestoneDetails(milestone, stageIndex, milestoneIndex);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: circleRadius * 2,
              height: circleRadius * 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: circleRadius,
                    backgroundColor: const Color(0xFF1D24CA),
                  ),
                  if (status == 'locked')
                    ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          color: Colors.black.withOpacity(0.2),
                          width: circleRadius * 2,
                          height: circleRadius * 2,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Icon(icon, color: iconColor, size: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnector() {
    return Container(height: 30, width: 4, color: Colors.grey.shade400);
  }

  // Helper to determine status dynamically (you might refine this logic)
  List<bool> milestoneCompletionStatus = [];

  @override
  void initState() {
    super.initState();
    _getRoadmap().then((_) {
      // Initialize completion status when roadmap is loaded
      if (_roadmap != null) {
        int totalMilestones = _roadmap!.stages.fold(
          0,
              (sum, stage) => sum + stage.milestones.length,
        );
        
        // Load existing completion status from current user, or create new if empty
        print("Total milestones: $totalMilestones");
        print("Current user milestone status from Firebase: ${UserDM.currentUser!.milestoneCompletionStatus}");
        
        if (UserDM.currentUser!.milestoneCompletionStatus.isNotEmpty && 
            UserDM.currentUser!.milestoneCompletionStatus.length == totalMilestones) {
          // Load existing completion status
          milestoneCompletionStatus = UserDM.currentUser!.milestoneCompletionStatus
              .map((value) => value.toLowerCase() == 'true').toList();
          print("Loaded existing completion status from Firebase");
        } else {
          // Initialize new completion status if none exists or length mismatch
          milestoneCompletionStatus = List<bool>.filled(totalMilestones, false);
          UserDM.currentUser!.milestoneCompletionStatus = 
              milestoneCompletionStatus.map((value) => value.toString()).toList();
          FirebaseServices.updateUserData(UserDM.currentUser!);
          print("Created new completion status - all false");
        }

        print("Final loaded milestone completion status: ${UserDM.currentUser!.milestoneCompletionStatus}");
        print("Final boolean array: $milestoneCompletionStatus");
        setState(() {}); // Refresh the UI with loaded data
      }
    });
  }

  // Modify the status determination
  String _getMilestoneStatus(int stageIndex, int milestoneIndex) {
    if (_roadmap == null || milestoneCompletionStatus.isEmpty) {
      return 'locked';
    }

    int globalIndex = 0;
    for (int i = 0; i < stageIndex; i++) {
      globalIndex += _roadmap!.stages[i].milestones.length;
    }
    globalIndex += milestoneIndex;

    if (globalIndex >= milestoneCompletionStatus.length) {
      return 'locked';
    }

    if (milestoneCompletionStatus[globalIndex]) {
      return 'completed';
    }

    int firstIncomplete = milestoneCompletionStatus.indexWhere((
        status) => !status);
    if (firstIncomplete == -1) return 'completed';
    if (globalIndex == firstIncomplete) return 'current';

    return 'locked';
  }

  @override
  Widget build(BuildContext context) {
    print(milestoneCompletionStatus.length);
    print(milestoneCompletionStatus);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          const SizedBox(height: 16.0),
          Expanded(
            child: _roadmap == null || milestoneCompletionStatus.isEmpty
                ? Center(
              child: CircularProgressIndicator(
                color: ColorsManager.blue,
              ),
            )
                : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: ColorsManager.blue,
                        child: Icon(
                          Icons.folder,
                          color: ColorsManager.white,
                        ),
                      ),
                      Text(
                        _roadmap!.targetJobRole,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesManager.analytics,
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: ColorsManager.blue,
                          child: Icon(
                            Icons.analytics_outlined,
                            color: ColorsManager.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildConnector(),
                  ..._roadmap!
                      .stages
                      .asMap()
                      .entries
                      .expand((stageEntry) {
                    final int stageIndex = stageEntry.key;
                    final RoadmapStage stage = stageEntry.value;

                    return stage.milestones
                        .asMap()
                        .entries
                        .map((milestoneEntry) {
                      final int milestoneIndex = milestoneEntry.key;
                      final Milestone milestone = milestoneEntry.value;

                      String status = _getMilestoneStatus(
                          stageIndex, milestoneIndex);

                      return Column(
                        children: [
                          _buildRoadmapItem(
                            milestone.name,
                            status,
                            milestone: milestone,
                            stageIndex: stageIndex,
                            milestoneIndex: milestoneIndex,
                          ),
                          _buildConnector(),
                        ],
                      );
                    }).toList();
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
