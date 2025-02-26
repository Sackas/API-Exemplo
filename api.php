<?php

class Database {
    private static $instance = null;
    private $connection;

    private function __construct() {
        $this->connection = new mysqli('localhost', 'root', '', 'movements');
        if ($this->connection->connect_error) {
            die("Connection failed: " . $this->connection->connect_error);
        }
    }

    public static function getInstance() {
        if (self::$instance === null) {
            self::$instance = new Database();
        }
        return self::$instance;
    }

    public function getConnection() {
        return $this->connection;
    }
}

class User {
    public $id;
    public $name;
}

class Movement {
    public $id;
    public $name;
}

class PersonalRecord {
    public $user_name;
    public $record;
    public $date;
}

class RankingService {
    private $db;

    public function __construct() {
        $this->db = Database::getInstance()->getConnection();
    }

    public function getRanking($movement_id) {
        $stmt = $this->db->prepare(
            "SELECT u.name as user_name, MAX(pr.value) as record, MAX(pr.date) as date 
             FROM personal_record pr 
             JOIN user u ON pr.user_id = u.id 
             WHERE pr.movement_id = ? 
             GROUP BY u.id, u.name 
             ORDER BY record DESC"
        );
        $stmt->bind_param("i", $movement_id);
        $stmt->execute();
        $result = $stmt->get_result();

        $ranking = [];
        $position = 1;
        $previousRecord = null;

        while ($row = $result->fetch_assoc()) {
            if ($previousRecord !== null && $row['record'] < $previousRecord) {
                $position++;
            }
            $ranking[] = [
                'position' => $position,
                'user_name' => $row['user_name'],
                'record' => $row['record'],
                'date' => $row['date']
            ];
            $previousRecord = $row['record'];
        }

        return [
            'movement' => $this->getMovementName($movement_id),
            'ranking' => $ranking
        ];
    }

    private function getMovementName($movement_id) {
        $stmt = $this->db->prepare("SELECT name FROM movement WHERE id = ?");
        $stmt->bind_param("i", $movement_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $movement = $result->fetch_assoc();
        return $movement ? $movement['name'] : 'Unknown';
    }
}

if (isset($_GET['movement_id'])) {
    $service = new RankingService();
    header('Content-Type: application/json');
    echo json_encode($service->getRanking($_GET['movement_id']));
} else {
    http_response_code(400);
    echo json_encode(['error' => 'Movement ID is required']);
}
