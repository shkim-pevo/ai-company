---
name: data-analysis
description: Data analysis workflow — exploratory analysis, visualization, statistical testing, and insight reporting using Python (pandas, matplotlib, seaborn) or SQL.
---

# Data Analysis Workflow

Structured data analysis process from question formulation to actionable insight delivery.

## When to Activate

- Analyzing datasets (CSV, Excel, database exports)
- Creating data visualizations and charts
- Running statistical tests or aggregations
- Building dashboards or reports from raw data
- Answering business questions with data evidence

## Core Principles

### 1. Question First

Always start with a clear question before touching data.

```
Bad:  "Let me explore this dataset"
Good: "What is the monthly retention rate by user cohort?"
```

### 2. Reproducibility

Every analysis should be reproducible — document data sources, transformations, and assumptions.

### 3. Honest Visualization

Never distort data with misleading axes, cherry-picked ranges, or inappropriate chart types.

## Analysis Workflow

### Phase 1: Define

1. **State the question** — What exactly are we trying to answer?
2. **Identify data sources** — Where does the data live? Is it complete?
3. **Define success criteria** — What would a useful answer look like?

### Phase 2: Explore

1. **Load and inspect** — Shape, types, nulls, distributions
2. **Clean** — Handle missing values, duplicates, outliers
3. **Summarize** — Key statistics, group-by aggregations

```python
import pandas as pd

# Standard exploration sequence
df = pd.read_csv("data.csv")
print(df.shape)
print(df.dtypes)
print(df.describe())
print(df.isnull().sum())
```

### Phase 3: Analyze

1. **Segment** — Break data into meaningful groups
2. **Compare** — Identify differences between segments
3. **Correlate** — Find relationships between variables
4. **Test** — Validate hypotheses with statistical tests

```python
# Segment analysis example
grouped = df.groupby("segment").agg(
    count=("id", "count"),
    avg_value=("value", "mean"),
    median_value=("value", "median"),
)
```

### Phase 4: Visualize

Choose chart types based on what you're showing:

| Purpose | Chart Type |
|---------|-----------|
| Trend over time | Line chart |
| Comparison | Bar chart |
| Distribution | Histogram / Box plot |
| Proportion | Pie / Stacked bar |
| Correlation | Scatter plot |
| Composition | Stacked area |

```python
import matplotlib.pyplot as plt
import seaborn as sns

# Always include: title, axis labels, legend
fig, ax = plt.subplots(figsize=(10, 6))
sns.barplot(data=df, x="category", y="value", ax=ax)
ax.set_title("Value by Category")
ax.set_xlabel("Category")
ax.set_ylabel("Value")
plt.tight_layout()
```

### Phase 5: Report

Structure findings as:
1. **Executive summary** — One-paragraph answer to the original question
2. **Key findings** — 3-5 bullet points with evidence
3. **Methodology** — Data sources, filters, assumptions
4. **Recommendations** — Actionable next steps

## SQL Analysis Patterns

```sql
-- Cohort retention analysis
WITH cohorts AS (
  SELECT
    user_id,
    DATE_TRUNC('month', first_action_at) AS cohort_month,
    DATE_TRUNC('month', action_at) AS action_month
  FROM user_actions
)
SELECT
  cohort_month,
  action_month,
  COUNT(DISTINCT user_id) AS active_users
FROM cohorts
GROUP BY 1, 2
ORDER BY 1, 2;
```

## Common Pitfalls

- **Survivorship bias** — Only analyzing users who stayed, ignoring churned
- **Simpson's paradox** — Aggregated trends hiding opposite segment trends
- **Confounding variables** — Correlation without controlling for third factors
- **Small sample sizes** — Drawing conclusions from insufficient data
- **p-hacking** — Running many tests until one "works"

## Tools

| Tool | Use Case |
|------|----------|
| pandas | Data manipulation and aggregation |
| matplotlib / seaborn | Static visualizations |
| plotly | Interactive visualizations |
| scipy.stats | Statistical tests |
| SQL | Database queries |
| xlsx skill | Spreadsheet output |

## Quality Checklist

- [ ] Original question is clearly stated
- [ ] Data source and date range documented
- [ ] Missing/null values addressed
- [ ] Visualizations have titles, labels, and legends
- [ ] Statistical claims include sample size and confidence
- [ ] Assumptions are explicitly noted
- [ ] Recommendations are actionable
