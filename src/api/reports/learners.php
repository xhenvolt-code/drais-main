<?php
header('Content-Type: application/json; charset=utf-8');
require_once '../../db.php'; // adjust path as needed

function calculate_age($dob) {
    if (!$dob) return '';
    $dob = new DateTime($dob);
    $now = new DateTime();
    $age = $now->diff($dob)->y;
    return $age;
}

// Fetch learners (customers) and their reports
$sql = "SELECT c.id, c.name, c.date_of_birth, c.email, c.phone, c.status, c.branch_id, b.name AS branch_name
        FROM customers c
        LEFT JOIN branches b ON c.branch_id = b.id
        WHERE c.status = 'active'";
$result = $conn->query($sql);
$learners = [];
while ($row = $result->fetch_assoc()) {
    $row['age'] = calculate_age($row['date_of_birth']);
    $learners[] = $row;
}

// Example: fetch results/grades for each learner (customize as needed)
foreach ($learners as &$learner) {
    $learner['grades'] = [];
    $grades_sql = "SELECT subject, score FROM results WHERE student_id = " . intval($learner['id']);
    $grades_result = $conn->query($grades_sql);
    while ($g = $grades_result->fetch_assoc()) {
        $learner['grades'][] = $g;
    }
}

// Arabic labels
$response = [
    'labels' => [
        'name' => 'الاسم',
        'age' => 'العمر',
        'email' => 'البريد الإلكتروني',
        'phone' => 'الهاتف',
        'status' => 'الحالة',
        'branch' => 'الفرع',
        'grades' => 'الدرجات',
        'subject' => 'المادة',
        'score' => 'الدرجة'
    ],
    'learners' => $learners
];
echo json_encode($response, JSON_UNESCAPED_UNICODE);
?>