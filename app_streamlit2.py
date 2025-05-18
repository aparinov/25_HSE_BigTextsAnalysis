import streamlit as st
import pandas as pd
import plotly.express as px

@st.cache_data
def load_data():
    """
    Загружает данные из Excel-файла 'parsed_data.xlsx',
    преобразует столбец 'publish_date' в формат datetime
    и возвращает DataFrame.
    """
    df = pd.read_excel('/home/polina/Dashboard/parsed_data_new_balanced.xlsx')
    df.rename(columns={'publish_date': 'Дата', 'category': 'Категория', 'type': 'Тип_новости'}, inplace=True)
    df['Дата'] = pd.to_datetime(df['Дата'], errors='coerce')
    return df


df = load_data()

if st.button("Обновить данные"):
    df = load_data()
    st.write("Данные обновлены!")

with st.spinner('Загрузка данных...'):
    df = load_data()


has_types = 'Тип_новости' in df.columns
has_titles = 'Заголовок' in df.columns


st.markdown("# 📰 Dashboard: Анализ новостей")
st.markdown("---")


total_news = len(df)
unique_categories = df['Категория'].nunique()
unique_types = df['Тип_новости'].nunique() if has_types else 0

col1, col2, col3 = st.columns(3)
col1.metric("Всего новостей", f"{total_news}")
col2.metric("Категорий", f"{unique_categories}")
col3.metric("Типов новостей", f"{unique_types}")
st.markdown("---")


tab1, tab2, tab3 = st.tabs(["📊 Аналитика", "🗂 Новости", "🔍 Детальный просмотр"])

with tab1:
    st.subheader("Выберите визуализацию")
    st.sidebar.header("Настройки визуализации")
    chart_option = st.sidebar.selectbox(
        "Тип графика:",
        [
            "📊 Количество по категориям",
            "📈 Распределение по времени",
            "🥧 По типу новости",
            "📦 Типы по категориям"
        ]
    )
    if st.sidebar.button("Построить график"):
        with st.spinner('Построение графика...'):
            if chart_option == "📊 Количество по категориям":
                data = df.groupby('Категория').size().reset_index(name='Количество')
                fig = px.bar(
                    data,
                    x='Категория',
                    y='Количество',
                    title='Количество новостей по категориям',
                    labels={'Категория':'Категория','Количество':'Количество'}
                )
                st.plotly_chart(fig, use_container_width=True)
            elif chart_option == "📈 Распределение по времени":
                fig = px.histogram(
                    df,
                    x='Дата',
                    nbins=30,
                    title='Распределение новостей по времени',
                    labels={'Дата':'Дата публикации','count':'Количество'}
                )
                st.plotly_chart(fig, use_container_width=True)
            elif chart_option == "🥧 По типу новости":
                if has_types:
                    data = df.groupby('Тип_новости').size().reset_index(name='Количество')
                    fig = px.pie(
                        data,
                        names='Тип_новости',
                        values='Количество',
                        title='Распределение по типу новости'
                    )
                    st.plotly_chart(fig, use_container_width=True)
                else:
                    st.warning("Столбец 'Тип_новости' не найден.")
            elif chart_option == "📦 Типы по категориям":
                if has_types:
                    data = df.groupby(['Категория','Тип_новости']).size().reset_index(name='Количество')
                    fig = px.bar(
                        data,
                        x='Категория',
                        y='Количество',
                        color='Тип_новости',
                        barmode='stack',
                        title='Распределение типов новостей по категориям'
                    )
                    st.plotly_chart(fig, use_container_width=True)
                else:
                    st.warning("Столбец 'Тип_новости' не найден.")
    else:
        st.info("Перейдите в боковую панель и нажмите 'Построить график'.")

with tab2:
    st.subheader("Новости по теме")
    topics = df['Категория'].unique().tolist()
    selected_topic = st.selectbox("Выберите тему:", topics)
    filtered = df[df['Категория'] == selected_topic]
    st.write(f"Всего новостей в категории {selected_topic}: {len(filtered)}")
    columns_to_show = ['project', 'Тип_новости', 'Категория', 'Дата']
    available_cols = [col for col in columns_to_show if col in filtered.columns]
    if available_cols:
        st.dataframe(filtered[available_cols], use_container_width=True)
    else:
        st.info("Нет доступных столбцов для отображения: project, Тип_новости, Категория, Дата.")

    if not filtered.empty and 'Дата' in filtered.columns:
        time_series = (
            filtered.set_index('Дата')
            .resample('D')
            .size()
            .reset_index(name='Количество')
        )
        time_series['Дата'] = time_series['Дата'].dt.date
        fig_ts = px.line(
            time_series,
            x='Дата',
            y='Количество',
            title=f"Динамика новостей по датам для темы '{selected_topic}'",
            labels={'Дата':'Дата','Количество':'Количество'}
        )
        st.plotly_chart(fig_ts, use_container_width=True)
    else:
        st.info("Недостаточно данных для построения графика временной динамики.")


with tab3:
    st.subheader("🔍 Детальная")


    category = st.selectbox("Категория:", df['Категория'].unique())
    df_cat = df[df['Категория'] == category].copy()


    if 'Тип_новости' in df_cat.columns:
        type_sel = st.selectbox("Тип новости:", df_cat['Тип_новости'].unique())
        df_type = df_cat[df_cat['Тип_новости'] == type_sel]
    else:
        df_type = df_cat


    df_type['Дата'] = pd.to_datetime(df_type['Дата'], errors='coerce')
    df_type['_date'] = df_type['Дата'].dt.date
    dates = sorted(df_type['_date'].dropna().unique())
    date_options = ['Без фильтра'] + dates
    date_sel = st.selectbox("Дата:", date_options)
    if date_sel != 'Без фильтра':
        df_date = df_type[df_type['_date'] == date_sel]
    else:
        df_date = df_type

    st.markdown("---")
    st.subheader("Список новостей по фильтру")

    if df_date.empty:
        st.info("Нет новостей по выбранным фильтрам")
    else:
        titles_df = (
            df_date[['title']]
            .rename(columns={'title': 'Заголовок'})
            .reset_index(drop=True)
        )
        st.table(titles_df)


        for _, row in df_date.iterrows():
            with st.expander(row['title']):
                body = row.get('body') or row.get('text', '')
                if body:
                    st.write(body)
                url = row.get('fronturl') or row.get('Ссылка', '')
                if url:
                    st.markdown(f"[Перейти к новости]({url})")


from pyngrok import ngrok

# Устанавливаем authtoken (если ещё не установлен)
ngrok.set_auth_token("2vY5DadOeazDA9BiiEa1fRNCbaB_66eenrbPgFVRuiEHAnMK7")

# Указываем порт для Streamlit (по умолчанию 8501)
port = 8501

# Создаем туннель через ngrok
from pyngrok import ngrok, exception

try:
    public_url = ngrok.connect(port, region="eu")  
    print("Streamlit публичный URL:", public_url)
except exception.PyngrokNgrokError as e:
    print("Не удалось запустить ngrok:", e)



# Запускаем приложение Streamlit
#ссылка для запуска дашборда streamlit run /home/polina/Dashboard/app_streamlit.py [ARGUMENTS]