import streamlit as st
from pyswip import Prolog
import json

# ==============================================================================
# 1. PROLOG ENGINE INITIALIZATION
# ==============================================================================

try:
    prolog = Prolog()
    prolog.consult("knowledge_base.pl")  # Load your Prolog file
except Exception as e:
    st.error(f"Error initializing Prolog or loading knowledge_base.pl:")
    st.error(f"Details: {e}")
    st.error("Please ensure SWI-Prolog is installed correctly (run: brew install swi-prolog) and the .pl file is in the same directory.")
    st.stop()


# ==============================================================================
# 2. STREAMLIT USER INTERFACE (From the new version)
# ==============================================================================

st.set_page_config(page_title="Tech Stack Advisor", page_icon="🧠", layout="wide")
st.title("🧠 Tech Stack Advisor (Prolog Edition)")
st.write("Answer the questions below to get a tech stack recommendation from our expert system.")

# This dictionary will hold all the answers
requirements = {}

# We use columns for a cleaner layout
col1, col2 = st.columns(2)

with col1:
    st.subheader("Project Basics")
    
    # Q1: Project Type
    project_type_map = {
        "Not sure / Skip": None,
        "E-commerce": "ecommerce",
        "CMS/Blog": "cms",
        "Social Media": "social",
        "Analytics Dashboard": "analytics",
        "Gaming/Interactive": "gaming",
        "General Web App": "general"
    }
    project_type_choice = st.selectbox("What type of project are you building?", list(project_type_map.keys()))
    requirements['project_type'] = project_type_map[project_type_choice]

    # Q2: SEO
    seo_map = {
        "Not sure / Skip": None,
        "Yes - Critical": "yes",
        "Yes - Important": "yes",
        "No - Not needed": "no"
    }
    seo_choice = st.selectbox("Is SEO (Search Engine Optimization) important?", list(seo_map.keys()))
    requirements['seo_important'] = seo_map[seo_choice]

    # Q3: Real-time
    realtime_map = {"Not sure / Skip": None, "Yes": "yes", "No": "no"}
    realtime_choice = st.selectbox("Do you need real-time features (live updates, chat)?", list(realtime_map.keys()))
    requirements['realtime'] = realtime_map[realtime_choice]

    # Q4: Team Size
    team_size_map = {
        "Not sure / Skip": None,
        "Small (1-3 developers)": "small",
        "Medium (4-10 developers)": "medium",
        "Large (10+ developers)": "large"
    }
    team_size_choice = st.selectbox("What's your team size?", list(team_size_map.keys()))
    requirements['team_size'] = team_size_map[team_size_choice]

    # Q5: Timeline
    timeline_map = {
        "Not sure / Skip": None,
        "Fast (MVP in 1-2 months)": "fast",
        "Moderate (3-6 months)": "moderate",
        "Long-term (6+ months)": "long"
    }
    timeline_choice = st.selectbox("What's your development timeline?", list(timeline_map.keys()))
    requirements['timeline'] = timeline_map[timeline_choice]

with col2:
    st.subheader("Technical Details")

    # Q6: Budget
    budget_map = {
        "Not sure / Skip": None,
        "Low (Under $100/month)": "low",
        "Medium ($100-500/month)": "medium",
        "High ($500+/month)": "high"
    }
    budget_choice = st.selectbox("What's your infrastructure budget?", list(budget_map.keys()))
    requirements['budget'] = budget_map[budget_choice]

    # Q7: Team Experience
    experience_map = {
        "Not sure / Skip": None,
        "JavaScript/TypeScript": "javascript",
        "Python": "python",
        "Java": "java",
        "Beginner/Mixed": "beginner"
    }
    experience_choice = st.selectbox("What's your team's primary language experience?", list(experience_map.keys()))
    requirements['team_experience'] = experience_map[experience_choice]

    # Q8: Scalability
    scalability_map = {
        "Not sure / Skip": None,
        "High - Expecting significant growth": "high",
        "Medium - Moderate growth": "medium",
        "Low - Small user base": "low"
    }
    scalability_choice = st.selectbox("How important is scalability?", list(scalability_map.keys()))
    requirements['scalability'] = scalability_map[scalability_choice]

    # Q9: Data Structure
    data_structure_map = {
        "Not sure / Skip": None,
        "Flexible/NoSQL (documents, varied schemas)": "flexible",
        "Structured/SQL (relational, fixed schemas)": "structured",
        "Mixed (both types)": "mixed"
    }
    data_structure_choice = st.selectbox("What type of data structure do you need?", list(data_structure_map.keys()))
    requirements['data_structure'] = data_structure_map[data_structure_choice]
    
    # Q10: Special Requirements
    st.subheader("Special Requirements")
    
    col_a, col_b, col_c = st.columns(3)
    with col_a:
        requirements['type_safety'] = "important" if st.toggle("Is type safety important?", value=False) else None
        requirements['api_heavy'] = "yes" if st.toggle("Is this an API-heavy app?", value=False) else None
        
    with col_b:
        requirements['mobile_app'] = "yes" if st.toggle("Do you need a mobile app?", value=False) else None
        if requirements['mobile_app'] == "yes":
            requirements['cross_platform'] = "yes" if st.toggle("Make it cross-platform?", value=True) else None
            
    with col_c:
        requirements['infrastructure'] = "serverless" if st.toggle("Prefer serverless?", value=False) else None
        if requirements['infrastructure'] == "serverless":
            requirements['maintenance'] = "low"

# --- "Get Recommendation" Button ---
if st.button("Analyze My Project", type="primary", use_container_width=True):
    
    # Filter out 'None' values
    final_requirements = {k: v for k, v in requirements.items() if v is not None}
    
    # --- Add implied facts ---
    if final_requirements.get('project_type') == 'ecommerce':
        final_requirements['payment_integration'] = 'yes'
    if final_requirements.get('project_type') == 'analytics':
        final_requirements['data_processing'] = 'heavy'
        final_requirements['visualization'] = 'important' # Match .pl file
    if final_requirements.get('project_type') == 'social':
        final_requirements['user_generated_content'] = 'yes' # Match .pl file
    if final_requirements.get('team_experience') == 'beginner':
        final_requirements['learning_curve'] = 'low'
    
    # --- Show a summary of the facts sent to the engine ---
    with st.expander("See all collected requirements (facts)"):
        st.json(final_requirements)
        
    # --- Run the Expert System (pyswip logic) ---
    try:
        # 1. Cleanup old facts
        prolog.retractall("requirement(_,_)")
        
        # 2. Assert all new facts
        for key, value in final_requirements.items():
            fact_string = f"requirement({key}, {value})"
            print(f"Asserting: {fact_string}") # For debugging
            prolog.assertz(fact_string)

        print(f"All facts asserted successfully: {final_requirements}")  # For debugging
        
        # 3. Query for ALL recommendations, not just the best one
        # This lets us show a ranked list
        query_string = "recommend_stack(frontend: F, backend: B, database: D, confidence: C, reason: R)"
        raw_results = list(prolog.query(query_string))

        print(f"Raw results from Prolog: {raw_results}")  # For debugging

        # 4. Cleanup facts immediately
        prolog.retractall("requirement(_,_)")
        
        # 5. Process results into a clean list of dictionaries
        recommendations = []
        if raw_results:
            for r in raw_results:
                recommendations.append({
                    'frontend': r['F'],
                    'backend': r['B'],
                    'database': r['D'],
                    'confidence': r['C'],
                    'reason': r['R']
                })
        
        st.divider()
        
        # --- Display the results ---
        if not recommendations:
            st.warning("No specific stack matched your unique criteria. Here's a solid, general-purpose stack:")
            st.info("""
            * **Frontend:** react
            * **Backend:** nodejs_express
            * **Database:** postgresql
            """)
        else:
            # Sort by confidence
            recommendations.sort(key=lambda x: x.get('confidence', 0), reverse=True)
            
            # st.balloons()
            st.header(f"🏆 Best Match: {recommendations[0]['frontend']} + {recommendations[0]['backend']}")
            
            # --- Prepare and show download button ---
            output_data = {
                'requirements': final_requirements,
                'best_match': recommendations[0],
                'all_recommendations': recommendations
            }
            st.download_button(
                label="Download Full Report (JSON)",
                data=json.dumps(output_data, indent=2),
                file_name="tech_stack_recommendations.json",
                mime="application/json"
            )

            # --- Display all matched recommendations in tabs ---
            tab_titles = [f"Rank #{i+1} ({rec['frontend']})" for i, rec in enumerate(recommendations)]
            tabs = st.tabs(tab_titles)
            
            for i, (tab, rec) in enumerate(zip(tabs, recommendations)):
                with tab:
                    st.subheader(f"{rec.get('frontend')} + {rec.get('backend')} + {rec.get('database')}")
                    st.metric("Confidence Score", f"{rec.get('confidence', 0) * 100:.1f}%")
                    
                    st.info(f"💡 **Reason:** {rec.get('reason', 'N/A')}")
                    
                    # Note: Your .pl file does not have a 'features' list,
                    # so that part of the UI is not included here.

    except Exception as e:
        st.error(f"An error occurred during Prolog query: {e}")
        st.error("This can happen if the facts asserted don't match the types in the .pl file.")
        # Ensure facts are cleaned up even on error
        prolog.retractall("requirement(_,_)")
