% ==============================================================================
% Tech Stack Advisor Knowledge Base (v4.0 - 50 Rules)
% ==============================================================================
%
% This knowledge base now contains 50 rules for comprehensive coverage.
% It strictly enforces data_structure (structured/flexible) and
% uses a fallback strategy for skipped questions.
%
% ==============================================================================

% --- Facts about technologies (unchanged) ---

frontend(react).
frontend(nextjs).
frontend(vue).
frontend(angular).
frontend(svelte).
frontend(vanilla_js).
frontend(react_native).

backend(nodejs_express).
backend(nestjs).
backend(django).
backend(flask).
backend(spring_boot).
backend(fastapi).
backend(ruby_rails).
backend(api_routes). % For serverless

database(mongodb).
database(postgresql).
database(mysql).
database(redis).
database(firebase).
database(dynamodb).
database(sqlite).

% ==============================================================================
% --- GROUP 1: E-COMMERCE RULES ---
% ==============================================================================

% Rule 1: Large-Scale E-commerce (SQL)
recommend_stack(
    frontend: nextjs,
    backend: nestjs,
    database: postgresql,
    confidence: 0.95,
    reason: 'Scalable e-commerce stack for a large, established business (SQL DB).'
) :-
    requirement(project_type, ecommerce),
    requirement(seo_important, yes),
    requirement(team_size, large),
    requirement(scalability, high),
    requirement(data_structure, structured).

% Rule 2: Small Business E-commerce (NoSQL)
recommend_stack(
    frontend: nextjs,
    backend: nodejs_express,
    database: mongodb,
    confidence: 0.88,
    reason: 'Cost-effective e-commerce stack for a small team or startup (NoSQL DB).'
) :-
    requirement(project_type, ecommerce),
    requirement(seo_important, yes),
    requirement(team_size, small),
    requirement(budget, low),
    requirement(data_structure, flexible).

% Rule 3: Medium E-commerce (SQL / JS Team)
recommend_stack(
    frontend: nextjs,
    backend: nestjs,
    database: postgresql,
    confidence: 0.90,
    reason: 'Balanced e-commerce stack for a medium, JS-focused team (SQL DB).'
) :-
    requirement(project_type, ecommerce),
    requirement(seo_important, yes),
    requirement(team_size, medium),
    requirement(team_experience, javascript),
    requirement(data_structure, structured).

% Rule 4: E-commerce Fallback (No DB/Language preference)
recommend_stack(
    frontend: nextjs,
    backend: nestjs,
    database: postgresql,
    confidence: 0.80,
    reason: 'Default high-performance stack for E-commerce with SEO (SQL DB assumed).'
) :-
    requirement(project_type, ecommerce),
    requirement(seo_important, yes),
    \+ requirement(team_experience, _),   
    \+ requirement(data_structure, _).    

% ==============================================================================
% --- GROUP 2: SOCIAL, REAL-TIME & GAMING RULES ---
% ==============================================================================

% Rule 5: Social Media Platform (NoSQL)
recommend_stack(
    frontend: react,
    backend: nestjs,
    database: mongodb,
    confidence: 0.91,
    reason: 'Social platform with real-time feeds and flexible user content (NoSQL DB).'
) :-
    requirement(project_type, social),
    requirement(realtime, yes),
    requirement(user_generated_content, yes),
    requirement(data_structure, flexible).

% Rule 6: Social Media (SQL)
recommend_stack(
    frontend: react,
    backend: django, % Django has strong auth/ORM for relational data
    database: postgresql,
    confidence: 0.85,
    reason: 'Social platform with structured user data and real-time (SQL DB).'
) :-
    requirement(project_type, social),
    requirement(realtime, yes),
    requirement(user_generated_content, yes),
    requirement(data_structure, structured).

% Rule 7: Gaming Platform (NoSQL/Cache)
recommend_stack(
    frontend: react, % Or a gaming-specific library
    backend: nodejs_express,
    database: redis, 
    confidence: 0.85,
    reason: 'Low-latency stack for gaming with real-time sync (NoSQL/Cache DB).'
) :-
    requirement(project_type, gaming),
    requirement(realtime, yes),
    requirement(data_structure, flexible).

% Rule 8: General Real-time App (NoSQL)
recommend_stack(
    frontend: react,
    backend: nestjs,
    database: mongodb,
    confidence: 0.82,
    reason: 'General real-time application with flexible data (NoSQL DB).'
) :-
    requirement(realtime, yes),
    \+ requirement(project_type, _), % Not for a specific project type
    requirement(team_experience, javascript),
    requirement(data_structure, flexible).

% ==============================================================================
% --- GROUP 3: ANALYTICS & DATA-HEAVY RULES ---
% ==============================================================================

% Rule 9: Analytics Dashboard (Python/SQL)
recommend_stack(
    frontend: react,
    backend: fastapi,
    database: postgresql,
    confidence: 0.92,
    reason: 'Analytics dashboard with high-performance Python data backend (SQL DB).'
) :-
    requirement(project_type, analytics),
    requirement(data_processing, heavy),
    requirement(team_experience, python),
    requirement(data_structure, structured).

% Rule 10: Analytics Dashboard (JS/SQL)
recommend_stack(
    frontend: react,
    backend: nestjs,
    database: postgresql,
    confidence: 0.88,
    reason: 'Analytics dashboard with a scalable, modern JS backend (SQL DB).'
) :-
    requirement(project_type, analytics),
    requirement(data_processing, heavy),
    requirement(team_experience, javascript),
    requirement(data_structure, structured).

% Rule 11: Analytics Dashboard (NoSQL)
recommend_stack(
    frontend: react,
    backend: fastapi,
    database: mongodb, % MongoDB is also viable for analytics
    confidence: 0.85,
    reason: 'Analytics dashboard with Python and a flexible data backend (NoSQL DB).'
) :-
    requirement(project_type, analytics),
    requirement(data_processing, heavy),
    requirement(team_experience, python),
    requirement(data_structure, flexible).

% Rule 12: API-Heavy (Python/SQL)
recommend_stack(
    frontend: react,
    backend: fastapi,
    database: postgresql,
    confidence: 0.87,
    reason: 'High-performance API with modern Python backend (SQL DB).'
) :-
    requirement(api_heavy, yes),
    requirement(team_experience, python),
    requirement(data_structure, structured).

% Rule 13: API-Heavy (Python/NoSQL)
recommend_stack(
    frontend: react,
    backend: fastapi,
    database: mongodb,
    confidence: 0.86,
    reason: 'High-performance API with modern Python backend (NoSQL DB).'
) :-
    requirement(api_heavy, yes),
    requirement(team_experience, python),
    requirement(data_structure, flexible).

% Rule 14: API-Heavy (JS/SQL)
recommend_stack(
    frontend: react,
    backend: nestjs,
    database: postgresql,
    confidence: 0.85,
    reason: 'High-performance API with modern JS backend (SQL DB).'
) :-
    requirement(api_heavy, yes),
    requirement(team_experience, javascript),
    requirement(data_structure, structured).

% ==============================================================================
% --- GROUP 4: CMS & SEO RULES ---
% ==============================================================================

% Rule 15: Content Management System (NoSQL)
recommend_stack(
    frontend: nextjs,
    backend: nodejs_express,
    database: mongodb,
    confidence: 0.86,
    reason: 'CMS with flexible content structure, ideal for small teams (NoSQL DB).'
) :-
    requirement(project_type, cms),
    requirement(data_structure, flexible),
    requirement(team_size, small).

% Rule 16: Headless CMS (SQL)
recommend_stack(
    frontend: nextjs,
    backend: django, % Django has a built-in admin panel
    database: postgresql,
    confidence: 0.84,
    reason: 'Headless CMS with Python backend and strong admin panel (SQL DB).'
) :-
    requirement(project_type, cms),
    requirement(data_structure, structured),
    requirement(team_experience, python).

% Rule 17: Enterprise SEO (SQL)
recommend_stack(
    frontend: nextjs,
    backend: nestjs,
    database: postgresql,
    confidence: 0.93,
    reason: 'Enterprise-grade SEO stack for a large, experienced JS team (SQL DB).'
) :-
    requirement(seo_important, yes),
    requirement(scalability, high),
    requirement(team_size, large),
    requirement(team_experience, javascript),
    requirement(data_structure, structured).

% Rule 18: Startup SEO (NoSQL)
recommend_stack(
    frontend: nextjs,
    backend: nodejs_express, 
    database: mongodb,       
    confidence: 0.88,
    reason: 'Cost-effective, fast-moving SEO stack for a small team (NoSQL DB).'
) :-
    requirement(seo_important, yes),
    requirement(team_size, small),
    requirement(budget, low),
    \+ requirement(realtime, yes),
    requirement(data_structure, flexible).

% ==============================================================================
% --- GROUP 5: TEAM EXPERIENCE & BEGINNER RULES ---
% ==============================================================================

% Rule 19: Enterprise (Java/SQL)
recommend_stack(
    frontend: angular,
    backend: spring_boot,
    database: postgresql,
    confidence: 0.96, 
    reason: 'Enterprise-grade stack for a Java team needing robustness (SQL DB).'
) :-
    requirement(team_size, large),
    requirement(type_safety, important),
    requirement(scalability, high),
    requirement(team_experience, java),
    requirement(data_structure, structured).

% Rule 20: Enterprise (Java/NoSQL)
recommend_stack(
    frontend: angular,
    backend: spring_boot,
    database: mongodb,
    confidence: 0.90,
    reason: 'Enterprise-grade stack for a Java team with flexible data (NoSQL DB).'
) :-
    requirement(team_size, large),
    requirement(type_safety, important),
    requirement(scalability, high),
    requirement(team_experience, java),
    requirement(data_structure, flexible).

% Rule 21: Java Team General (SQL)
recommend_stack(
    frontend: react,         
    backend: spring_boot,
    database: postgresql,    
    confidence: 0.75,
    reason: 'Spring Boot is the industry-standard backend for a Java team (SQL DB).'
) :-
    requirement(team_experience, java),
    \+ requirement(team_size, large), 
    requirement(data_structure, structured).

% Rule 22: Java Team General (NoSQL)
recommend_stack(
    frontend: react,         
    backend: spring_boot,
    database: mongodb,    
    confidence: 0.75,
    reason: 'Spring Boot with MongoDB for a Java-experienced team (NoSQL DB).'
) :-
    requirement(team_experience, java),
    \+ requirement(team_size, large), 
    requirement(data_structure, flexible).

% Rule 23: Java Team (No DB preference)
recommend_stack(
    frontend: react,
    backend: spring_boot,
    database: postgresql,
    confidence: 0.74, 
    reason: 'Default Spring Boot stack for a Java team (SQL DB assumed).'
) :-
    requirement(team_experience, java),
    \+ requirement(team_size, large),
    \+ requirement(data_structure, _). % Catches skipped DB

% Rule 24: Python Team General (SQL)
recommend_stack(
    frontend: react,         
    backend: fastapi,        
    database: postgresql,    
    confidence: 0.75,
    reason: 'FastAPI is a modern, high-performance backend for a Python team (SQL DB).'
) :-
    requirement(team_experience, python),
    \+ requirement(api_heavy, yes),      
    \+ requirement(project_type, analytics),
    requirement(data_structure, structured).

% Rule 25: Python Team General (NoSQL)
recommend_stack(
    frontend: react,         
    backend: fastapi,        
    database: mongodb,    
    confidence: 0.75,
    reason: 'FastAPI with MongoDB for a Python-experienced team (NoSQL DB).'
) :-
    requirement(team_experience, python),
    \+ requirement(api_heavy, yes),      
    \+ requirement(project_type, analytics),
    requirement(data_structure, flexible).

% Rule 26: Python Team (No DB preference)
recommend_stack(
    frontend: react,
    backend: fastapi,
    database: postgresql,
    confidence: 0.74, 
    reason: 'Default FastAPI stack for a Python team (SQL DB assumed).'
) :-
    requirement(team_experience, python),
    \+ requirement(api_heavy, yes),
    \+ requirement(project_type, analytics),
    \+ requirement(data_structure, _). % Catches skipped DB

% Rule 27: Beginner-Friendly (SQL)
recommend_stack(
    frontend: react,
    backend: flask,
    database: sqlite,
    confidence: 0.80,
    reason: 'Beginner-friendly stack with a gentle learning curve (SQL DB).'
) :-
    requirement(team_experience, beginner),
    requirement(learning_curve, low),
    requirement(data_structure, structured).

% Rule 28: Beginner-Friendly (NoSQL)
recommend_stack(
    frontend: react,
    backend: nodejs_express, 
    database: mongodb,
    confidence: 0.80,
    reason: 'Beginner-friendly stack with a gentle learning curve (NoSQL DB).'
) :-
    requirement(team_experience, beginner),
    requirement(learning_curve, low),
    requirement(data_structure, flexible).

% Rule 29: Beginner (No DB preference)
recommend_stack(
    frontend: react,
    backend: nodejs_express, 
    database: mongodb, % NoSQL is often easier for beginners
    confidence: 0.79,
    reason: 'Default beginner stack (NoSQL DB assumed for flexibility).'
) :-
    requirement(team_experience, beginner),
    requirement(learning_curve, low),
    \+ requirement(data_structure, _). % Catches skipped DB

% Rule 30: Beginner + SEO
recommend_stack(
    frontend: nextjs, % Next.js is good for SEO but has a learning curve
    backend: nodejs_express, 
    database: mongodb,
    confidence: 0.75,
    reason: 'Beginner stack for an SEO-focused project (NoSQL DB).'
) :-
    requirement(team_experience, beginner),
    requirement(seo_important, yes),
    requirement(data_structure, flexible).

% ==============================================================================
% --- GROUP 6: ARCHITECTURE & CONSTRAINT RULES ---
% ==============================================================================

% Rule 31: Small Team MVP (NoSQL/BaaS)
recommend_stack(
    frontend: nextjs,
    backend: api_routes, 
    database: firebase,  
    confidence: 0.85,
    reason: 'Fastest MVP for small team using serverless functions and BaaS (NoSQL DB).'
) :-
    requirement(team_size, small),
    requirement(timeline, fast),
    requirement(budget, low),
    requirement(data_structure, flexible).

% Rule 32: Small Team MVP (SQL/BaaS)
recommend_stack(
    frontend: nextjs,
    backend: api_routes, 
    database: supabase, % PostgreSQL BaaS
    confidence: 0.84,
    reason: 'Fastest MVP for small team using serverless functions and BaaS (SQL DB).'
) :-
    requirement(team_size, small),
    requirement(timeline, fast),
    requirement(budget, low),
    requirement(data_structure, structured).

% Rule 33: Startup Growth (JS/SQL)
recommend_stack(
    frontend: nextjs,
    backend: nestjs,
    database: postgresql,
    confidence: 0.90,
    reason: 'Balanced, scalable stack for a growing JS-based startup (SQL DB).'
) :-
    requirement(team_size, medium),
    requirement(scalability, high),
    requirement(timeline, moderate),
    requirement(team_experience, javascript),
    requirement(data_structure, structured).

% Rule 34: Startup Growth (JS/NoSQL)
recommend_stack(
    frontend: nextjs,
    backend: nestjs,
    database: mongodb,
    confidence: 0.89,
    reason: 'Balanced, scalable stack for a growing JS-based startup (NoSQL DB).'
) :-
    requirement(team_size, medium),
    requirement(scalability, high),
    requirement(timeline, moderate),
    requirement(team_experience, javascript),
    requirement(data_structure, flexible).

% Rule 35: Cross-Platform Mobile App (NoSQL)
recommend_stack(
    frontend: react_native,
    backend: nestjs,
    database: mongodb,
    confidence: 0.90,
    reason: 'React Native for cross-platform (iOS/Android) with a modern JS backend (NoSQL DB).'
) :-
    requirement(mobile_app, yes),
    requirement(cross_platform, yes),
    requirement(team_experience, javascript),
    requirement(data_structure, flexible).

% Rule 36: Cross-Platform Mobile App (SQL)
recommend_stack(
    frontend: react_native,
    backend: nestjs,
    database: postgresql,
    confidence: 0.88,
    reason: 'React Native for cross-platform (iOS/Android) with a modern JS backend (SQL DB).'
) :-
    requirement(mobile_app, yes),
    requirement(cross_platform, yes),
    requirement(team_experience, javascript),
    requirement(data_structure, structured).

% Rule 37: Mobile App Backend (Java)
recommend_stack(
    frontend: react_native, % Or native Android/iOS
    backend: spring_boot,
    database: postgresql,
    confidence: 0.85,
    reason: 'Java backend for a mobile application, good for enterprise integration (SQL DB).'
) :-
    requirement(mobile_app, yes),
    requirement(team_experience, java),
    requirement(data_structure, structured).

% Rule 38: Microservices (JS/SQL)
recommend_stack(
    frontend: react,
    backend: nestjs, % NestJS is excellent for microservices
    database: postgresql,
    confidence: 0.90,
    reason: 'Microservices-ready with modular JS backend (SQL DB).'
) :-
    requirement(architecture, microservices),
    requirement(team_size, large),
    requirement(team_experience, javascript),
    requirement(data_structure, structured).

% Rule 39: Microservices (Java/SQL)
recommend_stack(
    frontend: angular,
    backend: spring_boot,
    database: postgresql,
    confidence: 0.94,
    reason: 'Enterprise microservices with Spring Boot (SQL DB).'
) :-
    requirement(architecture, microservices),
    requirement(team_size, large),
    requirement(team_experience, java),
    requirement(data_structure, structured).

% Rule 40: Microservices (Python/SQL)
recommend_stack(
    frontend: react,
    backend: fastapi, % Multiple FastAPI services
    database: postgresql,
    confidence: 0.87,
    reason: 'Python-based microservices, good for ML/data (SQL DB).'
) :-
    requirement(architecture, microservices),
    requirement(team_experience, python),
    requirement(data_structure, structured).

% Rule 41: Serverless Application (NoSQL)
recommend_stack(
    frontend: nextjs,
    backend: api_routes, 
    database: dynamodb,  
    confidence: 0.83,
    reason: 'Fully serverless architecture with low maintenance (NoSQL DB).'
) :-
    requirement(infrastructure, serverless),
    requirement(maintenance, low),
    requirement(budget, low),
    requirement(data_structure, flexible).

% Rule 42: Serverless (Python)
recommend_stack(
    frontend: react,
    backend: flask, % Deployed on AWS Lambda or Google Cloud Functions
    database: dynamodb,  
    confidence: 0.82,
    reason: 'Serverless Python backend for data processing (NoSQL DB).'
) :-
    requirement(infrastructure, serverless),
    requirement(team_experience, python),
    requirement(data_structure, flexible).

% ==============================================================================
% --- GROUP 7: GENERAL FALLBACK RULES ---
% ==============================================================================

% Rule 43: General Fallback (Medium Team, SQL)
recommend_stack(
    frontend: react,
    backend: nodejs_express,
    database: postgresql,
    confidence: 0.70, 
    reason: 'Solid, general-purpose stack for a standard project (SQL DB).'
) :-
    requirement(team_size, medium),
    \+ requirement(seo_important, yes),
    \+ requirement(realtime, yes),
    \+ requirement(infrastructure, serverless),
    requirement(data_structure, structured).

% Rule 44: General Fallback (Medium Team, NoSQL)
recommend_stack(
    frontend: react,
    backend: nodejs_express,
    database: mongodb,
    confidence: 0.70, 
    reason: 'Solid, general-purpose stack for a standard project (NoSQL DB).'
) :-
    requirement(team_size, medium),
    \+ requirement(seo_important, yes),
    \+ requirement(realtime, yes),
    \+ requirement(infrastructure, serverless),
    requirement(data_structure, flexible).

% Rule 45: General Fallback (Small Team, SQL)
recommend_stack(
    frontend: react,
    backend: flask,
    database: postgresql,
    confidence: 0.69,
    reason: 'Lightweight, general-purpose stack for a small team (SQL DB).'
) :-
    requirement(team_size, small),
    \+ requirement(seo_important, yes),
    \+ requirement(realtime, yes),
    \+ requirement(timeline, fast),
    requirement(data_structure, structured).

% Rule 46: General Fallback (Small Team, NoSQL)
recommend_stack(
    frontend: react,
    backend: nodejs_express,
    database: mongodb,
    confidence: 0.69,
    reason: 'Lightweight, general-purpose stack for a small team (NoSQL DB).'
) :-
    requirement(team_size, small),
    \+ requirement(seo_important, yes),
    \+ requirement(realtime, yes),
    \+ requirement(timeline, fast),
    requirement(data_structure, flexible).

% Rule 47: Fallback (No Language, No DB)
recommend_stack(
    frontend: react,
    backend: nodejs_express,
    database: postgresql,
    confidence: 0.65, 
    reason: 'Default general stack (SQL DB assumed).'
) :-
    \+ requirement(team_experience, _),
    \+ requirement(data_structure, _),
    \+ requirement(seo_important, yes),
    \+ requirement(realtime, yes),
    \+ requirement(project_type, _).

% Rule 48: Fallback (JS Team, No DB)
recommend_stack(
    frontend: react,
    backend: nodejs_express,
    database: postgresql,
    confidence: 0.72,
    reason: 'Default stack for a JS team (SQL DB assumed).'
) :-
    requirement(team_experience, javascript),
    \+ requirement(data_structure, _),
    \+ requirement(api_heavy, yes),
    \+ requirement(scalability, high).

% Rule 49: Fallback (Type Safety, No DB)
recommend_stack(
    frontend: nextjs, % Uses TypeScript
    backend: nestjs,  % Uses TypeScript
    database: postgresql,
    confidence: 0.78,
    reason: 'Default stack for a type-safe project (SQL DB assumed).'
) :-
    requirement(type_safety, important),
    \+ requirement(data_structure, _),
    \+ requirement(team_experience, java). % Java rule is more specific

% Rule 50: Fallback (High Scale, No DB)
recommend_stack(
    frontend: react,
    backend: nestjs,
    database: postgresql,
    confidence: 0.76,
    reason: 'Default stack for a high-scalability project (SQL DB assumed).'
) :-
    requirement(scalability, high),
    \+ requirement(data_structure, _),
    \+ requirement(team_size, large),
    \+ requirement(team_experience, _).


% ==============================================================================
% HELPER PREDICATES (Unchanged)
% ==============================================================================

% Get all matching stacks
all_recommendations(Stacks) :-
    findall(
        stack(F, Be, D, C, R),
        recommend_stack(frontend: F, backend: Be, database: D, confidence: C, reason: R),
        Stacks
    ).

% Get best recommendation
best_recommendation(Frontend, Backend, Database, Confidence, Reason) :-
    findall(
        conf(C, F, Be, D, R),
        recommend_stack(frontend: F, backend: Be, database: D, confidence: C, reason: R),
        AllStacks
    ),
    \+ AllStacks = [], % Ensure the list is not empty
    sort(0, @>=, AllStacks, [conf(Confidence, Frontend, Backend, Database, Reason)|_]).

% Query interface (for command-line testing)
ask_recommendation :-
    write('=== Tech Stack Advisor ==='), nl,
    write('Answer the following questions:'), nl, nl,
    
    % Collect requirements
    write('Is SEO important? (yes/no): '),
    read(SEO),
    assert(requirement(seo_important, SEO)),
    
    write('Need real-time features? (yes/no): '),
    read(Realtime),
    assert(requirement(realtime, Realtime)),
    
    write('Team size? (small/medium/large): '),
    read(TeamSize),
    assert(requirement(team_size, TeamSize)),
    
    write('Project type? (ecommerce/cms/social/analytics/gaming/general): '),
    read(ProjectType),
    assert(requirement(project_type, ProjectType)),

    write('Data structure? (structured/flexible): '),
    read(DataStructure),
    assert(requirement(data_structure, DataStructure)),

    write('Team experience? (javascript/python/java/beginner): '),
    read(TeamExp),
    assert(requirement(team_experience, TeamExp)),
    
    % Get recommendation
    (best_recommendation(F, Be, D, C, R) ->
        nl, explain_choice(F, Be, D, R),
        format('Confidence: ~2f%~n', [C*100])
    ;
        write('No matching stack found. Consider custom configuration.')
    ),
    
    % Clean up
    retractall(requirement(_, _)).
