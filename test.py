from typing import List, Dict, Optional
from dataclasses import dataclass

@dataclass
class User:
    name: str
    age: int
    email: Optional[str] = None

def calculate_scores(users: List[User]) -> Dict[str, float]:
    scores = {}
    
    for user in users:
        # This intentional error should be caught by pyright
        score = user.agee * 1.5
        
        # This should show type hints
        scores[user.name] = score
    
    return scores

# This should show type checking
users = [
    User(name="Alice", age=25),
    User(name="Bob", age=30, email="bob@example.com"),
    User("Charlie")  # This should show an error due to missing age
]

result = calculate_scores(users)
print(result)
