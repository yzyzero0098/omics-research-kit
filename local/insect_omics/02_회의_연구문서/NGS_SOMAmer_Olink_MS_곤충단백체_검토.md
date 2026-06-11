# NGS/SOMAmer, Olink, MS 기반 곤충 단백체 분석 검토

작성일: 2026-06-01

## 결론 요약

현재 곤충 시료, 특히 백강잠/누에/식용곤충의 단백체 후보 발굴 목적에는 **프로메타바이오 또는 유사 업체의 LC-MS/MS 기반 discovery proteomics가 1순위**다. 이유는 곤충 단백질을 실제 펩타이드 MS/MS 스펙트럼으로 동정하고, Bombyx mori, Beauveria bassiana, Tenebrio 등 종별/custom DB 검색을 할 수 있기 때문이다.

Illumina Protein Prep/SomaScan 및 Olink는 둘 다 “단백질을 DNA 신호로 바꿔 NGS/qPCR로 읽는 affinity proteomics”다. 처리량과 재현성은 강하지만, 기본 패널이 사람 또는 일부 마우스/임상 biomarker 중심이다. 곤충 전체 단백체 discovery에는 부적합하거나 검증 부담이 크다.

마크로젠의 Olink는 “array”라기보다 **항체쌍 기반 PEA(Proximity Extension Assay) + qPCR 또는 NGS readout**이다. Olink Explore는 NGS readout, Target 96은 qPCR readout에 가깝다.

## 1. 현재 프로젝트 맥락

로컬 자료 기준:

- `프로메타바이오_분석_팜플렛.pdf`: 프로메타바이오는 고분해능 질량분석 기반 서비스 업체. DDA global profiling, SWATH/DIA label-free quantification, labeling quantification, MRM 절대정량, PTM identification, targeted metabolomics를 제시한다. 보유 장비는 Thermo Exploris 480, SCIEX QTOF 5600+, SCIEX Q-trap 5500+, SCIEX ZenoTOF 8600.
- `마크로젠_미팅_LC-MS_견적.pdf` 및 기존 정리: LC-MS/MS, Orbitrap/Q-TOF/Triple Quad 기반 단백체/대사체/지질체 분석 설계가 중심이다.
- `곤충과제_1g샘플_분석방향.pdf`: 1 g 동결건조 분말 pilot을 QC, 후보 marker ranking, 본 분석 설계용으로 쓰는 전략. 단백체는 B. mori + B. bassiana DB 기반 LC-MS/MS 검색이 핵심이다.
- `식용곤충 단백체_지칠체 분석 참고자료.pdf`: 누에 및 거저리 혈림프에서 proteome, lipid/metabolite profiling을 하는 다중오믹스 접근을 제시한다.

즉 지금 과제의 핵심 질문은 “사람 혈장 biomarker panel을 잘 측정할 것인가”가 아니라, “곤충 원물/추출물에서 어떤 단백질/펩타이드/대사체/지질이 실제로 존재하고 차이가 나는가”다. 이 질문에는 MS 방식이 더 직접적이다.

## 2. Illumina Protein Prep / SomaScan / SOMAmer 원리

Illumina Protein Prep은 공식 자료상 “SOMAmer technology + Illumina library prep + NovaSeq sequencing”으로 9.5K 수준의 human protein을 plasma/serum에서 측정하는 자동화 NGS 기반 proteomics 솔루션이다.

원리:

1. SOMAmer는 slow off-rate modified aptamer로, 화학적으로 변형된 짧은 단일가닥 DNA aptamer다.
2. 각 SOMAmer는 특정 단백질 epitope에 결합하고, 동시에 고유 DNA tag 역할을 한다.
3. SOMAmer가 streptavidin bead 등에 고정된 상태에서 단백질을 포획한다.
4. 세척, UV photocleavage, 재포획 과정을 통해 비특이 결합을 줄인다.
5. 단백질 양은 단백질 자체를 읽는 것이 아니라, 결합 후 남은 SOMAmer abundance를 barcoded sequencing library로 변환해 NGS read count로 정량한다.
6. NovaSeq 6000 또는 NovaSeq X에서 sequencing하고 DRAGEN Protein Quantification 등으로 normalized protein expression count를 만든다.

중요한 해석:

- “NGS 기반 단백체”라고 해도 단백질 서열을 직접 시퀀싱하는 것이 아니다.
- 실제 측정 대상은 단백질에 결합한 DNA aptamer barcode다.
- 따라서 discovery가 아니라 “이미 설계·검증된 SOMAmer panel의 target protein abundance 측정”이다.
- 공식 Illumina Protein Prep 사양은 human plasma/serum, input 55 uL, 9464 unique human proteins, 10,326 SOMAmer reagents다.

## 3. MS 방식과 무엇이 다른가

MS 기반 proteomics의 원리:

1. 시료에서 단백질을 추출한다.
2. trypsin 등으로 peptide로 절단한다.
3. LC/HPLC/nanoLC로 peptide를 시간축으로 분리한다.
4. 질량분석기에서 precursor ion의 m/z를 측정하고, MS/MS fragmentation으로 fragment ion spectrum을 얻는다.
5. 스펙트럼을 단백질 DB와 대조해 peptide/protein을 동정한다.
6. DDA, DIA/SWATH, TMT, LFQ, PRM/MRM 등 방식으로 상대정량 또는 절대정량을 수행한다.

장비/방식별 의미:

| 용어 | 의미 | 이번 과제에서의 역할 |
|---|---|---|
| HPLC/LC/nanoLC | 분리 장치. 질량분석 전 peptide/metabolite/lipid를 분리 | 복잡한 곤충 추출물에서 혼합도를 낮춰 MS 동정률 증가 |
| Orbitrap | 고분해능/고질량정확도 질량분석기 | 비모델 곤충 shotgun proteomics, LFQ, DIA에 적합 |
| Q-TOF/TOF | time-of-flight 기반 고분해능 MS | SWATH/DIA, metabolomics, peptide profiling에 적합 |
| Triple Quad/QTRAP | 선택한 ion transition을 고감도로 정량 | 후보 단백질/peptide/metabolite validation, MRM/PRM류 targeted 정량 |
| DDA | 강한 precursor를 골라 MS/MS | discovery, DB 기반 protein ID에 사용 |
| DIA/SWATH | m/z window 전체를 반복 fragment | 반복 샘플 정량, 대량 샘플 비교에 유리 |
| TMT/iTRAQ | isobaric labeling | 여러 샘플 multiplex 정량 가능, 비용/설계 복잡 |
| PRM/MRM | 정해진 peptide/물질 targeted 정량 | 2단계 validation에 적합 |

핵심 차이:

| 항목 | SOMAmer/Illumina | Olink | LC-MS/MS |
|---|---|---|---|
| 검출 원리 | aptamer가 단백질 결합, DNA barcode NGS | 항체쌍이 단백질 동시 결합, DNA barcode qPCR/NGS | peptide ion의 m/z와 MS/MS spectrum 직접 측정 |
| discovery 성격 | 패널 내 discovery | 패널 내 biomarker discovery | 비표적 discovery 가능 |
| 타깃 제한 | SOMAmer가 있는 단백질 | 항체쌍이 있는 단백질 | DB와 MS 검출성에 좌우, custom DB 가능 |
| 종 의존성 | human 중심, 일부 비인간 cross-react 가능성 | human/mouse biomarker 중심 | 곤충 DB/custom transcriptome DB 사용 가능 |
| proteoform/PTM | epitope가 보존될 때만 간접 | epitope 의존 | PTM/peptide/proteoform 일부 직접 확인 가능 |
| 산출값 | 상대 abundance/normalized count | NPX 등 상대값 | peptide/protein ID, intensity, LFQ, spectrum evidence |
| 강점 | 초고처리량, 적은 혈장/혈청, 재현성 | 높은 특이성, 소량, 임상 biomarker 패널 | 비모델 생물, 새로운 단백질/펩타이드 후보 발굴 |
| 약점 | 패널 밖 단백질 불가, species cross-react 검증 필요 | 패널 밖 단백질 불가, 항체 species 문제 | 전처리/DB/QC 난이도, dynamic range, missing value |

## 4. Olink와 SomaScan/Illumina의 차이

Olink는 SOMAmer가 아니라 **PEA(Proximity Extension Assay)**다.

원리:

1. 같은 target protein의 서로 다른 epitope를 인식하는 항체 2개를 쓴다.
2. 각 항체에는 서로 상보적인 DNA oligo가 붙어 있다.
3. 두 항체가 같은 단백질에 동시에 붙어 가까워지면 DNA oligo가 hybridization/extension되어 unique DNA barcode가 만들어진다.
4. barcode를 PCR 증폭하고 qPCR 또는 NGS로 읽는다.

차이:

- SomaScan/Illumina: 하나의 aptamer/SOMAmer 기반 인식. NGS read count로 정량.
- Olink: 두 항체의 proximity requirement 때문에 원리상 이중인식 특이성이 강점. readout은 제품군에 따라 qPCR 또는 NGS.
- 둘 다 단백질 자체를 sequencing하는 것이 아니라 DNA barcode를 읽는다.

마크로젠 Olink 관련:

- 마크로젠 공식 페이지는 접근 오류가 있었지만 검색 스니펫과 과거 정리 기준으로 Olink PEA, Explore 384, Target 96을 제공하는 것으로 확인된다.
- Olink Explore HT 공식 사양은 약 5,400개 protein assay, plasma/serum 등 2 uL, NGS automated workflow다.
- Target 96은 92 proteins/panel 수준의 qPCR/NPX 기반 targeted panel 성격이다.

## 5. 곤충 시료에서는 무엇이 더 나은가

### Discovery 목적이면 MS가 우선

곤충 단백체, 백강잠 진위 판별, Beauveria 감염 signature, 기능성 peptide precursor 발굴은 “사람 혈장 biomarker panel”과 맞지 않는다. 곤충 시료는 다음 문제가 있다.

- SOMAmer/Olink 항체가 곤충 ortholog를 인식한다는 보장이 없다.
- 곤충 단백질은 human target과 sequence/structure가 다르다.
- fungal infection-derived protein/metabolite는 human panel에 거의 없다.
- edible insect protein, allergen, storage protein, lipoprotein, cuticle protein, antimicrobial peptide 등은 MS로 직접 찾아야 한다.
- Bombyx mori는 DB가 비교적 좋고, B. bassiana DB를 합쳐 host-fungus combined database search가 가능하다.

따라서 현재 상황에서는:

1. 1차 pilot: LC-MS/MS DDA 또는 DIA-LFQ로 곤충 단백체 discovery.
2. DB: B. mori + B. bassiana + 해당 곤충종 UniProt/NCBI/custom transcriptome DB.
3. 산출물: protein/peptide ID, LFQ intensity, PCA, volcano, heatmap, GO/KEGG, candidate marker table.
4. 2차 validation: 후보 peptide는 PRM/MRM, 후보 대사체/지질은 targeted LC-MS/MS, DNA marker는 qPCR/ddPCR.

### SOMAmer/Olink를 쓸 수 있는 경우

다음 조건이면 보조적으로 검토 가능하다.

- 목적이 곤충이 아니라 사람/마우스/세포 반응 biomarker 측정인 경우.
- 곤충 추출물을 처리한 human cell/animal plasma의 host response를 보는 경우.
- 특정 conserved protein이 SOMAmer/Olink target으로 있고, cross-reactivity를 업체가 검증해 주는 경우.

하지만 곤충 원물 자체의 proteome discovery에는 우선순위가 낮다.

## 6. 프로메타바이오 진행 시 확인해야 할 질문

프로메타바이오 또는 마크로젠 경유 의뢰 전 확인:

1. 곤충 시료 경험: 백강잠/누에/갈색거저리/흰점박이꽃무지/동애등에 등 비모델 시료 처리 경험.
2. 전처리: 동결건조 분말 또는 추출물 분말 각각에 대한 protein extraction protocol.
3. DB 검색: B. mori + B. bassiana combined DB, decoy DB, contaminant DB, FDR 1% 적용 여부.
4. 정량 방식: DDA-LFQ인지 DIA/SWATH-LFQ인지. 반복수가 충분하면 DIA가 정량 재현성에 유리.
5. raw data 제공: Thermo `.raw`, SCIEX `.wiff`, search result, peptide/protein table 제공 여부.
6. 검색 툴: MaxQuant, Proteome Discoverer, DIA-NN, Spectronaut, Mascot 등.
7. PTM/peptidomics: bioactive peptide 후보가 목적이면 trypsin digest proteomics와 별도 peptidomics 설계가 필요한지.
8. 시료량: 1 g에서 proteomics 50 mg, metabolomics 100 mg, lipidomics 100 mg, amino acid 100 mg 분취 가능 여부.
9. QC: identified protein 수, peptide 수, PSM 수, missing rate, technical CV, TIC/BPC, PCA 제공 여부.
10. 후보 검증: discovery 후 PRM/MRM targeted validation 견적 가능 여부.

## 7. 권장 의사결정

현재 과제에는 다음 전략이 가장 합리적이다.

1. **프로메타바이오 LC-MS/MS로 pilot 진행**: 특히 DDA 또는 DIA-LFQ 기반 단백체와 대사체/지질체를 함께 생산.
2. **Olink/Illumina/SomaScan은 배제 또는 보류**: 곤충 원물 discovery에는 human plasma/serum affinity panel의 species mismatch가 크다.
3. **마크로젠 Olink는 이번 목적의 대안으로 보기 어렵다**: 임상/인간 biomarker panel에는 좋지만 곤충 단백질 후보 발굴에는 맞지 않는다.
4. **추후 validation은 targeted MS로 전환**: 발견된 candidate peptide/protein/metabolite/lipid는 PRM/MRM 또는 ELISA/Western/qPCR 등으로 검증.
5. **백강잠 특화 설계**: 누에 baseline과 백강잠을 비교하고, B. bassiana protein/metabolite/DNA marker를 진위 판별 축으로 둔다.

## 참고한 주요 공개 자료

- Illumina Protein Prep product page: https://emea.illumina.com/products/by-type/sequencing-kits/library-prep-kits/protein-prep.html
- Illumina Protein Prep data sheet M-GL-02533: https://support.illumina.com/content/dam/illumina/gcs/assembled-assets/marketing-literature/illumina-protein-prep-data-sheet-m-gl-02533/illumina-protein-prep-data-sheet-m-gl-02533.pdf
- Illumina SOMAmer technology: https://www.illumina.com/techniques/multiomics/proteomics/technology.html
- Olink PEA technology: https://olink.com/technology/what-is-pea
- Olink Explore HT: https://olink.com/products/olink-explore-ht
- Olink Explore NGS paper: https://pmc.ncbi.nlm.nih.gov/articles/PMC8633680/
- Bombyx mori LC-MS/MS proteomics example: https://www.nature.com/articles/srep21158
- Edible insect proteomics/allergen nano-LC-MS/MS example: https://pmc.ncbi.nlm.nih.gov/articles/PMC7911787/
- Edible insect protein review: https://pmc.ncbi.nlm.nih.gov/articles/PMC9562009/
